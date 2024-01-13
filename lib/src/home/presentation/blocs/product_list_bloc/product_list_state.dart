part of 'product_list_bloc.dart';

@immutable
class ProductListState {
  final List<ProductModel>? products;
  final FormSubmissionStatus formSubmissionStatus;
  final List<int> favouriteIds;

  const ProductListState(
      {this.products,
      this.formSubmissionStatus = const InitialFormStatus(),
      this.favouriteIds = const []});

  ProductListState copyWith({
    List<ProductModel>? products,
    FormSubmissionStatus? formSubmissionStatus,
    forceProductsToNull = false,
    List<int>? favouriteIds,
  }) {
    return ProductListState(
      formSubmissionStatus: formSubmissionStatus ?? this.formSubmissionStatus,
      products: forceProductsToNull ? null : products ?? this.products,
      favouriteIds: favouriteIds ?? this.favouriteIds,
    );
  }
}
