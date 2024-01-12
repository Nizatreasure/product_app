import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_app/globals.dart';

import 'core/routes/app_router.dart';
import 'core/values/theme_manager.dart';

void main() async {
  await Globals.initialize();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static final navigatorKey = GlobalKey<NavigatorState>();
  const MyApp._internal();
  static const MyApp instance = MyApp._internal();

  factory MyApp() => instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FlutterNativeSplash.remove();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Product App',
            routeInformationParser: MyAppRouter.router.routeInformationParser,
            routerDelegate: MyAppRouter.router.routerDelegate,
            routeInformationProvider:
                MyAppRouter.router.routeInformationProvider,
            theme: ThemeManager.getLightTheme(),
          ),
        );
      },
    );
  }
}
