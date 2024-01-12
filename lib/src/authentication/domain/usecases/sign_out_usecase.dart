import 'package:either_dart/either.dart';
import 'package:product_app/core/common/network/data_failure.dart';
import 'package:product_app/core/common/usecase/usecase.dart';
import 'package:product_app/src/authentication/data/repositories/auth_repository_impl.dart';

class SignOutUseCase implements BaseUseCase<dynamic, dynamic> {
  final AuthenticationRepository _authRepository;
  SignOutUseCase(this._authRepository);
  @override
  Future<Either<DataFailure, dynamic>> execute({required dynamic params}) {
    return _authRepository.signOut();
  }
}
