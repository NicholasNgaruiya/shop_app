import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/features/cart/ui/cart.dart';
import 'package:shop_app/features/home/bloc/home_bloc.dart';
import 'package:shop_app/features/home/ui/product_tile_widget.dart';
import 'package:shop_app/features/wishlist/ui/wishlist.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  final HomeBloc homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      //listen when the current state is an Action state
      listenWhen: (previous, current) => current is HomeActionState,
      //build when the current state is not an action state and instead its a Home State
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCartPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Cart()));
        } else if (state is HomeNavigateToWishListPageActionState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const WishList()));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.teal,
                title: const Text('Shop App'),
                actions: [
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeWishListNavigationEvent());
                      },
                      icon: const Icon(
                        Icons.favorite_border,
                      )),
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeCartNavigationEvent());
                      },
                      icon: const Icon(
                        Icons.shopping_cart_checkout_outlined,
                      )),
                ],
              ),
              body: ListView.builder(
                itemCount: successState.products.length,
                itemBuilder: (context, index) {
                  ProductTileWidget(
                      productDataModel: successState.products[index]);
                  return null;
                },
              ),
            );
          case HomeErrorState:
            return const Scaffold(
              body: Center(
                child: Text('Error'),
              ),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}
