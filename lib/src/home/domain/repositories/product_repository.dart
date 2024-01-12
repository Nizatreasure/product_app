part of '../../data/repositories/product_repository_impl.dart';

abstract class ProductsRepository {
  Future<Either<DataFailure, List<ProductModel>>> getProducts();
  Future<Either<DataFailure, ProductModel>> getSingleProduct(int productId);
}
