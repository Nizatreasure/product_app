part of '../../data/repositories/account_info_repository_impl.dart';

abstract class AccountInfoRepository {
  Future<Either<DataFailure, dynamic>> updateProfile(
      {String? email, String? name, String? imagePath});
}
