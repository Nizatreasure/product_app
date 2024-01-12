import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_app/core/common/widgets/custom_button.dart';
import 'package:product_app/core/common/widgets/custom_password_field.dart';
import 'package:product_app/core/common/widgets/custom_text_input_field.dart';
import 'package:product_app/core/values/fontsize_manager.dart';
import 'package:product_app/core/values/string_manager.dart';
import 'package:product_app/di.dart';
import 'package:product_app/src/authentication/presentation/blocs/sign_up_bloc/sign_up_bloc.dart';

part '../widgets/sign_up_widgets.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return BlocProvider<SignUpBloc>(
      create: (context) => getIt(),
      child: Scaffold(
        // appBar: AppBar(
        //   leading: const CustomBackButton(),
        //   backgroundColor: themeData.scaffoldBackgroundColor,
        // ),
        body: SafeArea(
          bottom: false,
          child: Builder(builder: (context) {
            return _buildBody(themeData, context);
          }),
        ),
      ),
    );
  }

  Widget _buildBody(ThemeData themeData, BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 20.w),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50.h),
            Text(
              StringManager.signUp,
              textAlign: TextAlign.center,
              style: themeData.textTheme.bodyLarge!.copyWith(
                fontSize: FontSizeManager.f24,
                color: themeData.canvasColor,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              StringManager.createAccountText,
              style: themeData.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30.h),
            _buildNameField(context),
            _buildEmailField(context),
            _buildPasswordField(context),
            SizedBox(height: 20.h),
            _buildButton(context),
            SizedBox(height: 30.h),
            _buildHaveAnAccount(context, themeData),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (_, state) {
      return CustomButton(
        text: StringManager.signUp,
        onTap: state.isValid ? () {} : null,
      );
    });
  }
}
