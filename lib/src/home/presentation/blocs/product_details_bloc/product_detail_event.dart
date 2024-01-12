part of 'product_detail_bloc.dart';

abstract class ProductDetailEvent {
  const ProductDetailEvent();
}

class ProductDetailSetProductIdEvent extends ProductDetailEvent {
  final int productId;
  const ProductDetailSetProductIdEvent(this.productId);
}

class ProductDetailGetDetailsEvent extends ProductDetailEvent {}
