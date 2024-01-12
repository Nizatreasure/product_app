part of 'product_list_bloc.dart';

@immutable
class ProductListState {
  final List<ProductModel>? products;
  final FormSubmissionStatus formSubmissionStatus;

  const ProductListState(
      {this.products, this.formSubmissionStatus = const InitialFormStatus()});

  ProductListState copyWith(
      {List<ProductModel>? products,
      FormSubmissionStatus? formSubmissionStatus,
      forceProductsToNull = false}) {
    return ProductListState(
        formSubmissionStatus: formSubmissionStatus ?? this.formSubmissionStatus,
        products: forceProductsToNull ? null : products ?? this.products);
  }
}
