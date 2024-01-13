import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:product_app/core/common/enums/enums.dart';
import 'package:product_app/core/common/network/connection_checker.dart';
import 'package:product_app/core/common/network/data_failure.dart';
import 'package:product_app/core/services/network_request_service.dart';
import 'package:product_app/src/home/data/data_sources/remote_data_sources.dart';
import 'package:product_app/src/home/data/models/product_model.dart';

part '../../domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductsRepository {
  final ProductsRemoteDataSource _productsRemoteDataSource;
  final NetworkRequestService _networkRequestService;

  final ConnectionChecker _connectionChecker;
  static final _collectionRef =
      FirebaseFirestore.instance.collection('favourites');
  static final _auth = FirebaseAuth.instance;

  ProductRepositoryImpl(this._networkRequestService,
      this._productsRemoteDataSource, this._connectionChecker);

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

  @override
  Future<Either<DataFailure, DocumentSnapshot>> getFavourites() async {
    if (await _connectionChecker.isConnected) {
      try {
        DocumentSnapshot snapshot =
            await _collectionRef.doc(_auth.currentUser?.uid).get();
        return Right(snapshot);
      } catch (e) {
        return Left(ErrorHandler.handleError(e).failure);
      }
    } else {
      return Left(DataStatus.connectionError.getFailure()!);
    }
  }

  @override
  Future<Either<DataFailure, dynamic>> saveFavourites(List<int> faves) async {
    if (await _connectionChecker.isConnected) {
      try {
        await _collectionRef.doc(_auth.currentUser?.uid).set({'id': faves});
        return const Right('');
      } catch (e) {
        return Left(ErrorHandler.handleError(e).failure);
      }
    } else {
      return Left(DataStatus.connectionError.getFailure()!);
    }
  }
}
