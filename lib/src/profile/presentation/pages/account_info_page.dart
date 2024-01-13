import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_app/core/common/widgets/custom_app_bar.dart';
import 'package:product_app/core/common/widgets/custom_button.dart';
import 'package:product_app/core/common/widgets/custom_text_input_field.dart';
import 'package:product_app/core/values/fontsize_manager.dart';
import 'package:product_app/core/values/string_manager.dart';
import 'package:product_app/di.dart';
import 'package:product_app/src/profile/presentation/blocs/account_info_bloc/account_info_bloc.dart';

part '../widgets/account_info_widgets.dart';

class AccountInfoPage extends StatefulWidget {
  const AccountInfoPage({super.key});

  @override
  State<AccountInfoPage> createState() => _AccountInfoPageState();
}

class _AccountInfoPageState extends State<AccountInfoPage> {
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    User? user = FirebaseAuth.instance.currentUser;
    return BlocProvider<AccountInfoBloc>(
      create: (context) => getIt()
        ..add(
          AccountInfoSetDataEvent(
              name: user?.displayName ?? StringManager.unknown,
              email: user?.email ?? 'unknown@unknown.com'),
        ),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: customAppBar(context,
              title: StringManager.accountInfo, centerTitle: true),
          body: Padding(
            padding: EdgeInsetsDirectional.symmetric(horizontal: 20.w),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 15.h),
                  CircleAvatar(radius: 50.r),
                  SizedBox(height: 13.h),
                  Text(
                    user?.displayName ?? StringManager.unknown,
                    style: themeData.textTheme.bodyMedium!.copyWith(
                        fontSize: FontSizeManager.f18,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(user?.email ?? 'noemail@noemail.com'),
                  SizedBox(height: 45.h),
                  _buildNameField(context),
                  _buildEmailField(context),
                  SizedBox(height: 20.h),
                  _buildButton(context),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildButton(BuildContext context) {
    return BlocBuilder<AccountInfoBloc, AccountInfoState>(builder: (_, state) {
      return CustomButton(
        text: StringManager.update,
        onTap: () {},
      );
    });
  }
}
