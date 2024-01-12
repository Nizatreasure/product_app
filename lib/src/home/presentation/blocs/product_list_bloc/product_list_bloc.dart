import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_app/core/common/form_submission/form_submission.dart';
import 'package:product_app/src/home/data/models/product_model.dart';
import 'package:product_app/src/home/domain/usecases/product_list_usecase.dart';

part 'product_list_events.dart';
part 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  final ProductListUseCase _productListUseCase;
  ProductListBloc(this._productListUseCase) : super(const ProductListState()) {
    on<ProductListGetProductsEvent>(_getProductsEventHandler);
  }

  _getProductsEventHandler(
      ProductListGetProductsEvent event, Emitter<ProductListState> emit) async {
    if (state.formSubmissionStatus is SubmittingForm) return;
    emit(state.copyWith(formSubmissionStatus: SubmittingForm()));
    final dataState = await _productListUseCase.execute(params: null);
    if (dataState.isRight) {
      emit(state.copyWith(
          formSubmissionStatus: SubmissionSuccess(dataState.right),
          products: dataState.right));
    } else {
      emit(state.copyWith(
          formSubmissionStatus: SubmissionFailure(dataState.left)));
    }
  }
}
