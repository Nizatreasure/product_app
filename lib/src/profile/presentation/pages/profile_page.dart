import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:product_app/core/common/widgets/custom_app_bar.dart';
import 'package:product_app/core/common/widgets/custom_button.dart';
import 'package:product_app/core/common/widgets/custom_dialog.dart';
import 'package:product_app/core/routes/route_names.dart';
import 'package:product_app/core/values/asset_manager.dart';
import 'package:product_app/core/values/fontsize_manager.dart';
import 'package:product_app/core/values/string_manager.dart';
import 'package:product_app/src/authentication/presentation/blocs/sign_in_bloc/sign_in_bloc.dart';

part '../widgets/profile_widgets.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: customAppBar(
        context,
        title: StringManager.myProfile,
        showBackButton: false,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 20.h),
        child: Column(
          children: [
            _profileButton(
              imagePath: AppAssetManager.account,
              title: StringManager.accountInfo,
              themeData: themeData,
              onTap: () {},
            ),
            _profileButton(
              imagePath: AppAssetManager.location,
              title: StringManager.myLocation,
              themeData: themeData,
            ),
            _profileButton(
              imagePath: AppAssetManager.order,
              title: StringManager.myOrders,
              themeData: themeData,
            ),
            _profileButton(
              imagePath: AppAssetManager.settings,
              title: StringManager.settings,
              themeData: themeData,
            ),
            _buildSignOutButton(themeData)
          ],
        ),
      ),
    );
  }

  Widget _buildSignOutButton(ThemeData themeData) {
    return CustomButton(
      text: StringManager.signOut,
      backgroundColor: Colors.transparent,
      textColor: themeData.canvasColor,
      showDisabledState: false,
      width: 200.w,
      onTap: () async {
        bool logout = await showCustomDialog(
          context,
          title: StringManager.logout,
          body: StringManager.logoutConfirmation,
          confirmButtonText: StringManager.yes,
          cancelButtonText: StringManager.no,
          showCancelButton: true,
        );
        if (context.mounted && logout) {
          context.read<SignInBloc>().add(SignOutSubmittedEvent());
          context.goNamed(RouteNames.signIn);
        }
      },
    );
  }
}
