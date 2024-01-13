import 'package:product_app/core/services/storage_service.dart';

class UserData {
  static String _email = '';
  static bool _rememberMe = false;

  static set email(String value) {
    _email = value;
    StorageServices.saveData('email', value);
  }

  static set rememberMe(bool value) {
    _rememberMe = value;
    StorageServices.saveData('remember_me', value);
  }

  static String get email => _email;
  static bool get rememberMe => _rememberMe;

  static Future<void> initialize() async {
    _email = await StorageServices.getData('email') ?? '';
    _rememberMe = await StorageServices.getData('remember_me') ?? false;
  }
}
