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
      dialogBackgroundColor: ColorManager.lightBlue.withOpacity(0.5),
      dividerColor: ColorManager.tintOrange,
      canvasColor: ColorManager.orange,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: ColorManager.white,
        selectedItemColor: ColorManager.orange,
        unselectedItemColor: ColorManager.lightBlack,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: _boldTextStyle(
          color: ColorManager.orange,
          fontSize: FontSizeManager.f10,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.2,
        ),
        unselectedLabelStyle: _normalTextStyle(
          color: ColorManager.lightBlack,
          fontSize: FontSizeManager.f10,
          letterSpacing: -0.2,
        ),
      ),
    );
  }

  static TextStyle _boldTextStyle({
    double? fontSize,
    Color? color,
    double? letterSpacing,
    FontWeight? fontWeight,
  }) {
    return GoogleFonts.poppins(
      color: color ?? ColorManager.black,
      fontSize: fontSize?.sp.clamp(14, 35) ?? FontSizeManager.f16,
      fontWeight: fontWeight ?? FontWeight.w700,
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
