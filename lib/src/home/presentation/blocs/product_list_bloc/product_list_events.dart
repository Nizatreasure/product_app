part of 'product_list_bloc.dart';

abstract class ProductListEvent {
  const ProductListEvent();
}

class ProductListGetProductsEvent extends ProductListEvent {}

class ProductListGetFavouritesEvent extends ProductListEvent {}

class ProductListSetFavouritesEvent extends ProductListEvent {
  final int productId;
  const ProductListSetFavouritesEvent(this.productId);
}
