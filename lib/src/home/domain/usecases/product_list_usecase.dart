import 'package:either_dart/either.dart';
import 'package:product_app/core/common/network/data_failure.dart';
import 'package:product_app/core/common/usecase/usecase.dart';
import 'package:product_app/src/home/data/models/product_model.dart';
import 'package:product_app/src/home/data/repositories/product_repository_impl.dart';

class ProductListUseCase extends BaseUseCase<dynamic, List<ProductModel>> {
  final ProductsRepository _productsRepository;
  ProductListUseCase(this._productsRepository);
  @override
  Future<Either<DataFailure, List<ProductModel>>> execute(
      {required dynamic params}) {
    return _productsRepository.getProducts();
  }
}
