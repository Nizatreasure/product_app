import 'package:product_app/core/services/storage_service.dart';

class UserData {
  static String _token = '';
  static bool _isFirstOpen = true;
  static bool _rememberMe = false;

  static set token(String value) {
    _token = value;
    StorageServices.saveData('token', value);
  }

  static set isFirstOpen(bool value) {
    _isFirstOpen = value;
    StorageServices.saveData('first_open', value);
  }

  static set rememberMe(bool value) {
    _rememberMe = value;
    StorageServices.saveData('remember_me', value);
  }

  static String get token => _token;
  static bool get isFirstOpen => _isFirstOpen;
  static bool get rememberMe => _rememberMe;

  static Future<void> initialize() async {
    _token = await StorageServices.getData('token') ?? '';

    _isFirstOpen = await StorageServices.getData('first_open') ?? true;
    _rememberMe = await StorageServices.getData('remember_me') ?? false;
  }
}
