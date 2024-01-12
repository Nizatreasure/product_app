import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';

import '../../../main.dart';
import '../../values/color_manager.dart';

class CustomLoader {
  static BuildContext? _context;

  static showLoader() async {
    if (_context?.mounted ?? false) {
      dismissLoader();
    }

    ThemeData themeData = Theme.of(MyApp.navigatorKey.currentContext!);
    showDialog(
      barrierDismissible: false,
      useRootNavigator: true,
      barrierColor: ColorManager.black.withOpacity(0.4),
      context: MyApp.navigatorKey.currentContext!,
      builder: (pageContext) {
        _context = pageContext;
        return PopScope(
          canPop: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Positioned.fill(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                      child: Container(
                        color: ColorManager.transparent,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50.r,
                    width: 50.r,
                    child: SpinKitFoldingCube(
                      size: 50.r,
                      itemBuilder: (context, index) {
                        return DecoratedBox(
                          decoration: const BoxDecoration(),
                          child: Container(
                            margin: EdgeInsetsDirectional.all(1.r),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3.r),
                              border: Border.all(
                                color: index % 2 == 0
                                    ? themeData.textTheme.bodyMedium!.color!
                                    : themeData.canvasColor,
                                width: 5.r,
                              ),
                              color: index % 2 == 0
                                  ? themeData.canvasColor
                                  : themeData.textTheme.bodyMedium!.color,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  static dismissLoader() async {
    if (_context != null) {
      _context!.pop();
      _context = null;
    }
  }
}
