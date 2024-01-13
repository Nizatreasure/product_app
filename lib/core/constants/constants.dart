import 'package:camera/camera.dart';

class AppConstants {
  //strings
  static const String boxName = 'product-app-box';
  static const String baseUrl = 'https://fakestoreapi.com';

  //list
  static List<FlashMode> get flashMode =>
      [FlashMode.auto, FlashMode.always, FlashMode.off, FlashMode.torch];
}
