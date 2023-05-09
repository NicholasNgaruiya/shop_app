import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/data/grocery_data.dart';
import 'package:shop_app/features/home/models/product_data_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeProductCartButtonClickedEvent>(homeProductCartButtonClickedEvent);
    on<HomeProductFavouriteButtonClickedEvent>(
        homeProductFavouriteButtonClickedEvent);
    on<HomeWishListNavigationEvent>(homeWishListNavigationEvent);
    on<HomeCartNavigationEvent>(homeCartNavigationEvent);
  }
  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(const Duration(seconds: 3));
    emit(HomeLoadedSuccessState(GroceryData.products
        .map((e) => ProductDataModel(
              e['id'],
              e['name'],
              e['description'],
              e['price'],
              e['imageUrl'],
            ))
        .toList()));
  }

  FutureOr<void> homeProductCartButtonClickedEvent(
      HomeProductCartButtonClickedEvent event, Emitter<HomeState> emit) {
    print('Add to cart button clicked');
  }

  FutureOr<void> homeProductFavouriteButtonClickedEvent(
      HomeProductFavouriteButtonClickedEvent event, Emitter<HomeState> emit) {
    print('Add to favourites button clicked');
  }

  FutureOr<void> homeWishListNavigationEvent(
      HomeWishListNavigationEvent event, Emitter<HomeState> emit) {
    print('Open WishList button clicked');
    emit(HomeNavigateToWishListPageActionState());
  }

  FutureOr<void> homeCartNavigationEvent(
      HomeCartNavigationEvent event, Emitter<HomeState> emit) {
    print('Open Cart button clicked');
    emit(HomeNavigateToCartPageActionState());
  }
}
