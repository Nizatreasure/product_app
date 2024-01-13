import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:product_app/core/routes/route_names.dart';
import 'package:product_app/globals.dart';
import 'package:product_app/main.dart';
import 'package:product_app/src/authentication/presentation/pages/sign_in_page.dart';
import 'package:product_app/src/authentication/presentation/pages/sign_up_page.dart';
import 'package:product_app/src/home/presentation/pages/product_details_page.dart';
import 'package:product_app/src/landing/presentation/pages/landing_page.dart';
import 'package:product_app/src/profile/presentation/blocs/account_info_bloc/account_info_bloc.dart';
import 'package:product_app/src/profile/presentation/blocs/take_photo_bloc/take_photo_bloc.dart';
import 'package:product_app/src/profile/presentation/pages/account_info_page.dart';
import 'package:product_app/src/profile/presentation/pages/take_photo_page.dart';

import '../common/widgets/custom_page_transition.dart';

class MyAppRouter {
  static GoRouter router = GoRouter(
    navigatorKey: MyApp.navigatorKey,
    // initialLocation: RouteNames.landing,
    routes: [
      GoRoute(
        name: RouteNames.signIn,
        path: RouteNames.signIn,
        pageBuilder: (context, state) {
          return CustomPageTransition(child: const SignInPage());
        },
        redirect: (context, state) async {
          if (FirebaseAuth.instance.currentUser != null) {
            return RouteNames.landing;
          }
          return null;
        },
      ),
      GoRoute(
        name: RouteNames.signUp,
        path: RouteNames.signUp,
        pageBuilder: (context, state) {
          return CustomPageTransition(child: const SignUpPage());
        },
      ),
      GoRoute(
        name: RouteNames.landing,
        path: RouteNames.landing,
        pageBuilder: (context, state) {
          return CustomPageTransition(child: const LandingPage());
        },
        routes: [
          GoRoute(
            name: RouteNames.productDetails,
            path: '${RouteNames.productDetails}/:id',
            pageBuilder: (context, state) {
              return CustomPageTransition(
                child: ProductDetailsPage(
                  productId:
                      int.tryParse(state.pathParameters['id'] ?? '1') ?? 1,
                ),
              );
            },
          ),
          GoRoute(
            name: RouteNames.accountInfo,
            path: RouteNames.accountInfo,
            pageBuilder: (context, state) {
              return CustomPageTransition(child: const AccountInfoPage());
            },
          ),
          GoRoute(
            name: RouteNames.takePhoto,
            path: RouteNames.takePhoto,
            pageBuilder: (context, state) {
              return CustomPageTransition(
                  child: BlocProvider<TakePhotoBloc>(
                      create: (context) => TakePhotoBloc()
                        ..add(TakePhotoInitialEvent(Globals.cameras.first)),
                      child: TakePhoto(state.extra as AccountInfoBloc)));
            },
          ),
        ],
      ),
    ],
  );
}
