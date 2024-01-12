import 'package:flutter_screenutil/flutter_screenutil.dart';

class FontSizeManager {
  static double get f10 => 10.sp.clamp(9, 15);
  // static double get f11 => 11.sp.clamp(10, 18);
  static double get f12 => 12.sp.clamp(10, 21);
  // static double get f13 => 13.sp.clamp(12, 19.5);
  static double get f14 => 14.sp.clamp(12, 25);
  static double get f16 => 16.sp.clamp(14, 30);
  // static double get f18 => 18.sp.clamp(16, 35);
  // static double get f20 => 20.sp.clamp(18, 40);
  static double get f24 => 24.sp.clamp(22, 55);
}
