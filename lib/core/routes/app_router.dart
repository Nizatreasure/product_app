import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:product_app/core/routes/route_names.dart';
import 'package:product_app/main.dart';
import 'package:product_app/src/authentication/presentation/pages/sign_in_page.dart';
import 'package:product_app/src/authentication/presentation/pages/sign_up_page.dart';
import 'package:product_app/src/home/presentation/pages/product_details_page.dart';
import 'package:product_app/src/landing/presentation/pages/landing_page.dart';

class MyAppRouter {
  static GoRouter router = GoRouter(
    navigatorKey: MyApp.navigatorKey,
    initialLocation: RouteNames.landing,
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
      GoRoute(
          name: RouteNames.landing,
          path: RouteNames.landing,
          pageBuilder: (context, state) {
            return const MaterialPage(child: LandingPage());
          },
          routes: [
            GoRoute(
              name: RouteNames.productDetails,
              path: RouteNames.productDetails,
              pageBuilder: (context, state) {
                return const MaterialPage(child: ProductDetailsPage());
              },
            ),
          ]),
    ],
  );
}
