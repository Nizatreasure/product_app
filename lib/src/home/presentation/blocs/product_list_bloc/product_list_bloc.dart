import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_app/core/common/form_submission/form_submission.dart';
import 'package:product_app/src/home/data/models/product_model.dart';
import 'package:product_app/src/home/domain/usecases/get_favourites.dart';
import 'package:product_app/src/home/domain/usecases/product_list_usecase.dart';
import 'package:product_app/src/home/domain/usecases/save_favourite_usecase.dart';

part 'product_list_events.dart';
part 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  final ProductListUseCase _productListUseCase;
  final SaveFavouritesUseCase _saveFavouritesUseCase;
  final GetFavouritesUseCase _getFavouritesUseCase;
  ProductListBloc(this._productListUseCase, this._getFavouritesUseCase,
      this._saveFavouritesUseCase)
      : super(const ProductListState()) {
    on<ProductListGetProductsEvent>(_getProductsEventHandler);
    on<ProductListGetFavouritesEvent>(_getFavouritesEventHandler);
    on<ProductListSetFavouritesEvent>(_setFavouritesEventHandler);
  }

  _getProductsEventHandler(
      ProductListGetProductsEvent event, Emitter<ProductListState> emit) async {
    add(ProductListGetFavouritesEvent());
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

  _getFavouritesEventHandler(ProductListGetFavouritesEvent event,
      Emitter<ProductListState> emit) async {
    final dataState = await _getFavouritesUseCase.execute(params: null);
    if (dataState.isRight) {
      emit(state.copyWith(
          favouriteIds:
              ((dataState.right.data() as Map?)?['id'] as List<dynamic>?)
                  ?.map((e) => int.parse(e.toString()))
                  .toList()));
    } else {
      await Future.delayed(const Duration(seconds: 3));
      add(ProductListGetFavouritesEvent());
    }
  }

  _setFavouritesEventHandler(ProductListSetFavouritesEvent event,
      Emitter<ProductListState> emit) async {
    bool remove = state.favouriteIds.contains(event.productId);
    List<int> newList = List.from(state.favouriteIds);
    if (remove) {
      newList.remove(event.productId);
    } else {
      newList.add(event.productId);
    }
    emit(state.copyWith(favouriteIds: newList));

    await _saveFavouritesUseCase.execute(params: state.favouriteIds);
  }
}
