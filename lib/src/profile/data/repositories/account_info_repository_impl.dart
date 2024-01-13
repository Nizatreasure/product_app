import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:product_app/core/common/enums/enums.dart';
import 'package:product_app/core/common/network/data_failure.dart';

import '../../../../core/common/network/connection_checker.dart';

part '../../domain/repositories/account_info_repository.dart';

class AccountInfoRepositoryImpl implements AccountInfoRepository {
  final ConnectionChecker _connectionChecker;
  static final _auth = FirebaseAuth.instance;
  AccountInfoRepositoryImpl(this._connectionChecker);
  @override
  Future<Either<DataFailure, dynamic>> updateProfile(
      {String? email, String? name, String? imagePath}) async {
    if (await _connectionChecker.isConnected) {
      try {
        if (name != null) {
          await _auth.currentUser?.updateDisplayName(name);
        }
        if (email != null) {
          await _auth.currentUser?.verifyBeforeUpdateEmail(email);
        }
        if (imagePath != null) {
          await _auth.currentUser?.updatePhotoURL(imagePath);
        }
        return const Right('');
      } catch (e) {
        return Left(ErrorHandler.handleError(e).failure);
      }
    } else {
      return Left(DataStatus.connectionError.getFailure()!);
    }
  }
}
