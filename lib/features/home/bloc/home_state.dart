part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

//the state below is abstract since it is responsible for building the initial home
abstract class HomeActionState extends HomeState {}

class HomeInitial extends HomeState {}

//the below classs are responsible for creating actionable states such as loading,loaded ,error etc

class HomeLoadingState extends HomeState {}

class HomeLoadedSuccessState extends HomeState {
  final List<ProductDataModel> products;

  HomeLoadedSuccessState(this.products);
}

class HomeErrorState extends HomeState {}

class HomeNavigateToWishListPageActionState extends HomeActionState {}

class HomeNavigateToCartPageActionState extends HomeActionState {}
