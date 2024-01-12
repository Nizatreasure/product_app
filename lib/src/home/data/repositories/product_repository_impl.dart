import 'package:either_dart/either.dart';
import 'package:product_app/core/common/network/data_failure.dart';
import 'package:product_app/core/services/network_request_service.dart';
import 'package:product_app/src/home/data/data_sources/remote_data_sources.dart';
import 'package:product_app/src/home/data/models/product_model.dart';

part '../../domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductsRepository {
  final ProductsRemoteDataSource _productsRemoteDataSource;
  final NetworkRequestService _networkRequestService;

  ProductRepositoryImpl(
      this._networkRequestService, this._productsRemoteDataSource);
  @override
  Future<Either<DataFailure, List<ProductModel>>> getProducts() {
    return _networkRequestService.makeRequest<List<ProductModel>>(request: () {
      return _productsRemoteDataSource.getProducts();
    });
  }

  @override
  Future<Either<DataFailure, ProductModel>> getSingleProduct(int productId) {
    return _networkRequestService.makeRequest<ProductModel>(request: () {
      return _productsRemoteDataSource.getSingleProduct(productId);
    });
  }
}
