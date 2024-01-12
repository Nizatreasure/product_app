import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_app/core/common/form_submission/form_submission.dart';
import 'package:product_app/src/home/data/models/product_model.dart';
import 'package:product_app/src/home/domain/usecases/single_product_usecase.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final ProductSingleUseCase _productSingleUseCase;
  ProductDetailBloc(this._productSingleUseCase)
      : super(const ProductDetailState()) {
    on<ProductDetailGetDetailsEvent>(_getProductDetailEventHandler);
    on<ProductDetailSetProductIdEvent>(_setProductIdEventHandler);
  }

  _setProductIdEventHandler(
      ProductDetailSetProductIdEvent event, Emitter<ProductDetailState> emit) {
    emit(const ProductDetailState().copyWith(productId: event.productId));
    add(ProductDetailGetDetailsEvent());
  }

  _getProductDetailEventHandler(ProductDetailGetDetailsEvent event,
      Emitter<ProductDetailState> emit) async {
    if (state.formSubmissionStatus is SubmittingForm) return;
    emit(state.copyWith(formSubmissionStatus: SubmittingForm()));
    final dataState =
        await _productSingleUseCase.execute(params: state.productId ?? 1);
    if (dataState.isRight) {
      emit(state.copyWith(
          formSubmissionStatus: SubmissionSuccess(dataState.right),
          productDetails: dataState.right));
    } else {
      emit(state.copyWith(
          formSubmissionStatus: SubmissionFailure(dataState.left)));
    }
  }
}
