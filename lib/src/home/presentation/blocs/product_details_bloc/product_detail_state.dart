part of 'product_detail_bloc.dart';

@immutable
class ProductDetailState {
  final ProductModel? productDetails;
  final FormSubmissionStatus formSubmissionStatus;
  final int? productId;

  const ProductDetailState({
    this.productDetails,
    this.formSubmissionStatus = const InitialFormStatus(),
    this.productId,
  });

  ProductDetailState copyWith({
    ProductModel? productDetails,
    FormSubmissionStatus? formSubmissionStatus,
    int? productId,
  }) {
    return ProductDetailState(
        productDetails: productDetails ?? this.productDetails,
        productId: productId ?? this.productId,
        formSubmissionStatus:
            formSubmissionStatus ?? this.formSubmissionStatus);
  }
}
