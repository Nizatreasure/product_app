part of '../pages/sign_up_page.dart';

Widget _buildEmailField(BuildContext context,
    [TextEditingController? controller]) {
  return BlocBuilder<SignUpBloc, SignUpState>(
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
          context.read<SignUpBloc>().add(SignUpEmailChangedEvent(val));
        },
      );
    },
  );
}

Widget _buildNameField(BuildContext context) {
  return BlocBuilder<SignUpBloc, SignUpState>(
    builder: (_, state) {
      return CustomTextInputField(
        hintText: StringManager.fullName,
        fieldName: StringManager.enterFullName,
        onChanged: (val) {
          context.read<SignUpBloc>().add(SignUpNameChangedEvent(val));
        },
      );
    },
  );
}

Widget _buildPasswordField(BuildContext context) {
  return BlocBuilder<SignUpBloc, SignUpState>(
    builder: (_, state) {
      return CustomPasswordField(
        showPassword: state.showPassword,
        onChanged: (val) {
          context.read<SignUpBloc>().add(SignUpPasswordChangedEvent(val!));
        },
        hintText: StringManager.enterPassword,
        toggleVisibility: () {
          context
              .read<SignUpBloc>()
              .add(SignUpTogglePasswordVisibility(!state.showPassword));
        },
      );
    },
  );
}

_buildHaveAnAccount(BuildContext context, ThemeData themeData) {
  return Text.rich(
    TextSpan(
      text: StringManager.haveAnAccount,
      style: themeData.textTheme.bodyMedium,
      children: [
        TextSpan(
          text: ' ${StringManager.signIn}',
          style: TextStyle(
              color: themeData.canvasColor, fontWeight: FontWeight.w600),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              context.goNamed(RouteNames.signIn);
            },
        ),
      ],
    ),
  );
}
