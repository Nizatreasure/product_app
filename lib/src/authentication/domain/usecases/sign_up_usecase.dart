import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:product_app/core/common/network/data_failure.dart';
import 'package:product_app/core/common/usecase/usecase.dart';
import 'package:product_app/src/authentication/data/repositories/auth_repository_impl.dart';

class SignUpUseCase
    implements BaseUseCase<Map<String, dynamic>, UserCredential> {
  final AuthenticationRepository _authRepository;
  SignUpUseCase(this._authRepository);
  @override
  Future<Either<DataFailure, UserCredential>> execute(
      {required Map<String, dynamic> params}) {
    return _authRepository.signUp(
        email: params['email'], password: params['password']);
  }
}
