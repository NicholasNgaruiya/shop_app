part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class HomeProductCartButtonClickedEvent extends HomeEvent {}

class HomeProductFavouriteButtonClickedEvent extends HomeEvent {}

class HomeWishListNavigationEvent extends HomeEvent {}

class HomeCartNavigationEvent extends HomeEvent {}
