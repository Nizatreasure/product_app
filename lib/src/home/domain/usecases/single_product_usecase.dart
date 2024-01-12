import 'package:either_dart/either.dart';
import 'package:product_app/core/common/network/data_failure.dart';
import 'package:product_app/core/common/usecase/usecase.dart';
import 'package:product_app/src/home/data/models/product_model.dart';
import 'package:product_app/src/home/data/repositories/product_repository_impl.dart';

class ProductSingleUseCase extends BaseUseCase<int, ProductModel> {
  final ProductsRepository _productsRepository;
  ProductSingleUseCase(this._productsRepository);
  @override
  Future<Either<DataFailure, ProductModel>> execute({required int params}) {
    return _productsRepository.getSingleProduct(params);
  }
}
