import 'package:hive_flutter/hive_flutter.dart';

import '../common/user_data.dart';
import '../constants/constants.dart';

class StorageServices {
  static late final Box _productAppBox;

  static Future<void> initialize() async {
    await Hive.initFlutter();
    _productAppBox = await Hive.openBox(AppConstants.boxName);
    await UserData.initialize();
  }

  static Future<void> closeBox() async {
    await _productAppBox.close();
  }

  static Future<int> clearBox() async {
    return await _productAppBox.clear();
  }

  static Future<void> deleteData(String key) async {
    await _productAppBox.delete(key);
  }

  static Future<void> deleteMultiple(List<String> keys) async {
    await _productAppBox.deleteAll(keys);
  }

  static bool containsKey(String key) {
    return _productAppBox.containsKey(key);
  }

  static bool isBoxOpen() {
    return _productAppBox.isOpen;
  }

  static Future<dynamic> getData(String key) async {
    return await _productAppBox.get(key);
  }

  static Future<void> saveData(String key, dynamic value) async {
    await _productAppBox.put(key, value);
  }

  static Future<void> saveMultipleData(Map<String, dynamic> entries) async {
    await _productAppBox.putAll(entries);
  }
}
