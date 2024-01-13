import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:product_app/core/common/form_submission/form_submission.dart';
import 'package:product_app/core/common/widgets/custom_app_bar.dart';
import 'package:product_app/core/common/widgets/custom_button.dart';
import 'package:product_app/core/common/widgets/custom_dialog.dart';
import 'package:product_app/core/common/widgets/custom_text_input_field.dart';
import 'package:product_app/core/routes/route_names.dart';
import 'package:product_app/core/values/asset_manager.dart';
import 'package:product_app/core/values/color_manager.dart';
import 'package:product_app/core/values/fontsize_manager.dart';
import 'package:product_app/core/values/string_manager.dart';
import 'package:product_app/di.dart';
import 'package:product_app/globals.dart';
import 'package:product_app/src/authentication/presentation/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:product_app/src/profile/presentation/blocs/account_info_bloc/account_info_bloc.dart';

part '../widgets/account_info_widgets.dart';

class AccountInfoPage extends StatefulWidget {
  const AccountInfoPage({super.key});

  @override
  State<AccountInfoPage> createState() => _AccountInfoPageState();
}

class _AccountInfoPageState extends State<AccountInfoPage> {
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

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
          body: BlocListener<AccountInfoBloc, AccountInfoState>(
              listener: (context, state) async {
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
                  bool changedEmail = user?.email?.trim().toLowerCase() !=
                      state.email.trim().toLowerCase();
                  await showCustomDialog(
                    context,
                    title: StringManager.successful,
                    body: changedEmail
                        ? StringManager.changedEmailMessage
                        : StringManager.profileDetailsUpdatedSuccessfully,
                    confirmButtonText: StringManager.done,
                  );
                  if (context.mounted) {
                    changedEmail
                        ? context
                            .read<SignInBloc>()
                            .add(SignOutSubmittedEvent())
                        : context.pop();
                  }
                }
              },
              child: _buildBody(user, themeData, context)),
        );
      }),
    );
  }

  Widget _buildBody(User? user, ThemeData themeData, BuildContext context) {
    return BlocBuilder<AccountInfoBloc, AccountInfoState>(
        builder: (context, state) {
      return Padding(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 15.h),
              _buildImage(context, themeData, state, user),
              SizedBox(height: 13.h),
              Text(
                user?.displayName ?? StringManager.unknown,
                style: themeData.textTheme.bodyMedium!.copyWith(
                    fontSize: FontSizeManager.f18, fontWeight: FontWeight.w600),
              ),
              Text(user?.email ?? 'unknown@unknown.com'),
              SizedBox(height: 45.h),
              _buildNameField(context),
              _buildEmailField(context),
              SizedBox(height: 20.h),
              _buildButton(context, user),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildButton(BuildContext context, User? user) {
    return BlocBuilder<AccountInfoBloc, AccountInfoState>(builder: (_, state) {
      return CustomButton(
        text: StringManager.update,
        onTap: !state.isValid
            ? null
            : () async {
                bool isChangingEmail = user?.email?.trim().toLowerCase() !=
                    state.email.trim().toLowerCase();
                bool shouldContinue = !isChangingEmail
                    ? true
                    : await showCustomDialog(
                        context,
                        title: StringManager.reauthenticate,
                        body: StringManager.reauthenticateHint,
                        confirmButtonText: StringManager.continue_,
                        controller: _passwordController,
                        showCancelButton: true,
                        cancelButtonText: StringManager.cancel,
                        canPop: false,
                      );
                if (context.mounted && shouldContinue) {
                  String password = _passwordController.text.trim();
                  _passwordController.clear();
                  context.read<AccountInfoBloc>().add(
                        AccountInfoSubmittedEvent(
                          password: isChangingEmail ? password : null,
                          email: user?.email,
                          name: user?.displayName,
                          imagePath: user?.photoURL,
                        ),
                      );
                }
              },
      );
    });
  }
}
