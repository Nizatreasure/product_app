import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:product_app/core/common/enums/enums.dart';
import 'package:product_app/core/common/network/connection_checker.dart';
import 'package:product_app/core/common/network/data_failure.dart';
import 'package:product_app/core/routes/route_names.dart';
import 'package:product_app/main.dart';

part '../../domain/repositories/auth_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final ConnectionChecker _connectionChecker;
  static final _auth = FirebaseAuth.instance;
  AuthenticationRepositoryImpl(this._connectionChecker);

  @override
  Future<Either<DataFailure, UserCredential>> signUp(
      {required String email,
      required String password,
      required String name}) async {
    if (await _connectionChecker.isConnected) {
      try {
        final credential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        await credential.user?.updateDisplayName(name);
        return Right(credential);
      } catch (e) {
        return Left(ErrorHandler.handleError(e).failure);
      }
    } else {
      return Left(DataStatus.connectionError.getFailure()!);
    }
  }

  @override
  Future<Either<DataFailure, dynamic>> signOut() async {
    await _auth.signOut();
    MyApp.navigatorKey.currentContext?.goNamed(RouteNames.signIn);
    return const Right('');
  }

  @override
  Future<Either<DataFailure, UserCredential>> signIn(
      {required String email, required String password}) async {
    if (await _connectionChecker.isConnected) {
      try {
        final credential = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        return Right(credential);
      } catch (e) {
        return Left(ErrorHandler.handleError(e).failure);
      }
    } else {
      return Left(DataStatus.connectionError.getFailure()!);
    }
  }
}
