part of '../../data/repositories/auth_repository_impl.dart';

abstract class AuthenticationRepository {
  Future<Either<DataFailure, UserCredential>> signUp(
      {required String email, required String password, required String name});
  Future<Either<DataFailure, UserCredential>> signIn(
      {required String email, required String password});
  Future<Either<DataFailure, dynamic>> signOut();
}
