import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:product_app/core/routes/route_names.dart';
import 'package:product_app/main.dart';
import 'package:product_app/src/authentication/presentation/pages/sign_in_page.dart';
import 'package:product_app/src/authentication/presentation/pages/sign_up_page.dart';

class MyAppRouter {
  static GoRouter router = GoRouter(
    navigatorKey: MyApp.navigatorKey,
    routes: [
      GoRoute(
        name: RouteNames.signUp,
        path: RouteNames.signUp,
        pageBuilder: (context, state) {
          return const MaterialPage(child: SignUpPage());
        },
        // redirect: (context, state) {
        //   if (!UserData.isFirstOpen) {
        //     return UserData.token.isNotEmpty
        //         ? RouteNames.landing
        //         : RouteNames.signIn;
        //   }
        //   return null;
        // },
      ),
      GoRoute(
        name: RouteNames.signIn,
        path: RouteNames.signIn,
        pageBuilder: (context, state) {
          return const MaterialPage(child: SignInPage());
        },
      ),
    ],
  );
}
