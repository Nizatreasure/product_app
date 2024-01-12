import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:product_app/core/common/form_submission/form_submission.dart';
import 'package:product_app/core/common/widgets/custom_button.dart';
import 'package:product_app/core/common/widgets/custom_dialog.dart';
import 'package:product_app/core/common/widgets/custom_password_field.dart';
import 'package:product_app/core/common/widgets/custom_text_input_field.dart';
import 'package:product_app/core/routes/route_names.dart';
import 'package:product_app/core/values/fontsize_manager.dart';
import 'package:product_app/core/values/string_manager.dart';
import 'package:product_app/di.dart';

import '../blocs/sign_in_bloc/sign_in_bloc.dart';

part '../widgets/sign_in_widgets.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return BlocProvider<SignInBloc>(
      create: (context) => getIt(),
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: Builder(
            builder: (context) {
              return BlocListener<SignInBloc, SignInState>(
                listener: (context, state) {
                  if (state.formSubmissionStatus is SubmissionFailure) {
                    showCustomDialog(
                      context,
                      title: StringManager.error,
                      confirmButtonText: StringManager.close,
                      body: (state.formSubmissionStatus as SubmissionFailure)
                          .exception
                          .message!,
                    );
                  } else if (state.formSubmissionStatus is SubmissionSuccess) {
                    context.pushNamed(RouteNames.landing);
                  }
                },
                child: _buildBody(themeData, context),
              );
            },
          ),
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
              StringManager.signIn,
              textAlign: TextAlign.center,
              style: themeData.textTheme.bodyLarge!.copyWith(
                fontSize: FontSizeManager.f24,
                color: themeData.canvasColor,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              StringManager.signInText,
              style: themeData.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30.h),
            _buildEmailField(context),
            _buildPasswordField(context),
            _buildForgotPassword(themeData, context),
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
    return BlocBuilder<SignInBloc, SignInState>(builder: (_, state) {
      return CustomButton(
        text: StringManager.signIn,
        onTap: state.isValid
            ? () async {
                context.read<SignInBloc>().add(SignInSubmittedEvent());
              }
            : null,
      );
    });
  }
}
