import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color_manager.dart';
import 'fontsize_manager.dart';

class ThemeManager {
  static ThemeData getLightTheme() {
    return ThemeData.light().copyWith(
      scaffoldBackgroundColor: ColorManager.white,
      textTheme: TextTheme(
        bodyLarge: _boldTextStyle(letterSpacing: -0.28),
        bodyMedium: _normalTextStyle(),
      ),
      disabledColor: ColorManager.grey,
      colorScheme: const ColorScheme.light().copyWith(
        error: ColorManager.red,
      ),
      dividerColor: ColorManager.grey,
      canvasColor: ColorManager.orange,
    );
  }

  static TextStyle _boldTextStyle(
      {double? fontSize, Color? color, double? letterSpacing}) {
    return GoogleFonts.poppins(
      color: color ?? ColorManager.black,
      fontSize: fontSize?.sp.clamp(14, 35) ?? FontSizeManager.f16,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle _normalTextStyle(
      {double? fontSize, Color? color, double? letterSpacing}) {
    return GoogleFonts.poppins(
      color: color ?? ColorManager.black,
      fontSize: fontSize?.sp.clamp(10, 25) ?? FontSizeManager.f12,
      fontWeight: FontWeight.w400,
      letterSpacing: letterSpacing,
    );
  }
}
