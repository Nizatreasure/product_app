part of 'sign_in_bloc.dart';

class SignInState {
  final String email;
  final String password;
  final bool showPassword;
  final bool rememberMe;

  bool get isValid =>
      email.trim().isNotEmpty &&
      password.trim().length >= 5 &&
      EmailValidator.validate(email);

  final FormSubmissionStatus formSubmissionStatus;
  final FormSubmissionStatus logoutFormSubmissionStatus;

  const SignInState({
    this.email = '',
    this.password = '',
    this.showPassword = false,
    this.rememberMe = false,
    this.formSubmissionStatus = const InitialFormStatus(),
    this.logoutFormSubmissionStatus = const InitialFormStatus(),
  });

  SignInState copyWith({
    String? email,
    String? password,
    bool? showPassword,
    FormSubmissionStatus? formSubmissionStatus,
    FormSubmissionStatus? logoutFormSubmissionStatus,
    bool? rememberMe,
  }) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
      showPassword: showPassword ?? this.showPassword,
      formSubmissionStatus: formSubmissionStatus ?? this.formSubmissionStatus,
      logoutFormSubmissionStatus:
          logoutFormSubmissionStatus ?? this.logoutFormSubmissionStatus,
      rememberMe: rememberMe ?? this.rememberMe,
    );
  }
}
