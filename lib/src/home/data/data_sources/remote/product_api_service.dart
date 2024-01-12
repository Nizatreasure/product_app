import 'package:dio/dio.dart';
import 'package:product_app/src/home/data/models/product_model.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../core/constants/constants.dart';

part 'product_api_service.g.dart';

@RestApi(baseUrl: AppConstants.baseUrl)
abstract class ProductApiService {
  factory ProductApiService(Dio dio, {String? baseUrl}) = _ProductApiService;

  @GET('/products')
  Future<HttpResponse<List<ProductModel>>> getProducts();

  @GET('/products/{product_id}')
  Future<HttpResponse<ProductModel>> getSingleProduct(
      @Path('product_id') int productId);
}
