import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:product_app/core/common/network/data_failure.dart';
import 'package:product_app/core/common/usecase/usecase.dart';
import 'package:product_app/src/home/data/repositories/product_repository_impl.dart';

class GetFavouritesUseCase implements BaseUseCase<dynamic, DocumentSnapshot> {
  final ProductsRepository _productRepository;
  GetFavouritesUseCase(this._productRepository);
  @override
  Future<Either<DataFailure, DocumentSnapshot>> execute(
      {required dynamic params}) {
    return _productRepository.getFavourites();
  }
}
