part of '../pages/sign_in_page.dart';

Widget _buildEmailField(BuildContext context,
    [TextEditingController? controller]) {
  return BlocBuilder<SignInBloc, SignInState>(
    builder: (_, state) {
      return CustomTextInputField(
        fieldName: StringManager.emailAddress,
        hintText: StringManager.enterEmailAddress,
        textEditingController: controller,
        textCapitalization: TextCapitalization.none,
        inputFormatters: [
          FilteringTextInputFormatter.deny(RegExp(r'\s')),
        ],
        keyboardType: TextInputType.emailAddress,
        onChanged: (val) {
          context.read<SignInBloc>().add(SignInEmailChangedEvent(val));
        },
      );
    },
  );
}

Widget _buildPasswordField(BuildContext context) {
  return BlocBuilder<SignInBloc, SignInState>(
    builder: (_, state) {
      return CustomPasswordField(
        showPassword: state.showPassword,
        onChanged: (val) {
          context.read<SignInBloc>().add(SignInPasswordChangedEvent(val!));
        },
        hintText: StringManager.enterPassword,
        toggleVisibility: () {
          context
              .read<SignInBloc>()
              .add(SignInTogglePasswordVisibility(!state.showPassword));
        },
      );
    },
  );
}

_buildHaveAnAccount(BuildContext context, ThemeData themeData) {
  return Text.rich(
    TextSpan(
      text: StringManager.noAccount,
      style: themeData.textTheme.bodyMedium,
      children: [
        TextSpan(
          text: ' ${StringManager.signUp}',
          style: TextStyle(
              color: themeData.canvasColor, fontWeight: FontWeight.w600),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              context.goNamed(RouteNames.signUp);
            },
        ),
      ],
    ),
  );
}

Widget _buildForgotPassword(ThemeData themeData, BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      BlocBuilder<SignInBloc, SignInState>(builder: (context, state) {
        return Row(
          children: [
            SizedBox(
              width: 24.r,
              height: 24.r,
              child: Checkbox(
                value: state.rememberMe,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.r),
                ),
                activeColor: themeData.canvasColor,
                onChanged: (value) {
                  context.read<SignInBloc>().add(
                      SignInToggleRememberMeEvent(value ?? !state.rememberMe));
                },
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              StringManager.rememberMe,
              style: themeData.textTheme.bodyMedium,
            )
          ],
        );
      }),
      InkWell(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          padding: const EdgeInsetsDirectional.symmetric(
            vertical: 5,
          ),
          alignment: AlignmentDirectional.centerEnd,
          child: Text(
            '${StringManager.forgotPassword}?',
            style: themeData.textTheme.bodyMedium!
                .copyWith(color: themeData.canvasColor),
          ),
        ),
      ),
    ],
  );
}
