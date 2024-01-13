import 'package:either_dart/either.dart';
import 'package:product_app/core/common/network/data_failure.dart';
import 'package:product_app/core/common/usecase/usecase.dart';
import 'package:product_app/src/profile/data/repositories/account_info_repository_impl.dart';

class AccountInfoUseCase implements BaseUseCase<Map<String, dynamic>, dynamic> {
  final AccountInfoRepository _accountInfoRepository;
  AccountInfoUseCase(this._accountInfoRepository);

  @override
  Future<Either<DataFailure, dynamic>> execute(
      {required Map<String, dynamic> params}) {
    return _accountInfoRepository.updateProfile(
      email: params['email'],
      name: params['name'],
      imagePath: params['imagePath'],
    );
  }
}
