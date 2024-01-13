import 'package:either_dart/either.dart';
import 'package:product_app/core/common/network/data_failure.dart';
import 'package:product_app/core/common/usecase/usecase.dart';
import 'package:product_app/src/home/data/repositories/product_repository_impl.dart';

class SaveFavouritesUseCase implements BaseUseCase<List<int>, dynamic> {
  final ProductsRepository _productRepository;
  SaveFavouritesUseCase(this._productRepository);
  @override
  Future<Either<DataFailure, dynamic>> execute({required List<int> params}) {
    return _productRepository.saveFavourites(params);
  }
}
