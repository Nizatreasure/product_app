part of 'product_list_bloc.dart';

abstract class ProductListEvent {
  const ProductListEvent();
}

class ProductListGetProductsEvent extends ProductListEvent {}
