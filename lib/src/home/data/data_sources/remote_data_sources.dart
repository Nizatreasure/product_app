import 'package:product_app/src/home/data/data_sources/remote/product_api_service.dart';
import 'package:retrofit/retrofit.dart';

import '../models/product_model.dart';

abstract class ProductsRemoteDataSource {
  Future<HttpResponse<List<ProductModel>>> getProducts();
  Future<HttpResponse<ProductModel>> getSingleProduct(int productId);
}

class ProductsRemoteDataSourceImpl implements ProductsRemoteDataSource {
  final ProductApiService _productApiService;
  ProductsRemoteDataSourceImpl(this._productApiService);

  @override
  Future<HttpResponse<List<ProductModel>>> getProducts() async {
    return await _productApiService.getProducts();
  }

  @override
  Future<HttpResponse<ProductModel>> getSingleProduct(int productId) async {
    return await _productApiService.getSingleProduct(productId);
  }
}
