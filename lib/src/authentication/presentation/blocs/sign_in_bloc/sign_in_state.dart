part of 'sign_in_bloc.dart';

class SignInState {
  final String email;
  final String password;
  final bool showPassword;

  bool get isValid =>
      email.trim().isNotEmpty &&
      password.trim().length >= 5 &&
      EmailValidator.validate(email);

  final FormSubmissionStatus formSubmissionStatus;

  const SignInState({
    this.email = '',
    this.password = '',
    this.showPassword = false,
    this.formSubmissionStatus = const InitialFormStatus(),
  });

  SignInState copyWith({
    String? email,
    String? password,
    bool? showPassword,
    FormSubmissionStatus? formSubmissionStatus,
  }) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
      showPassword: showPassword ?? this.showPassword,
      formSubmissionStatus: formSubmissionStatus ?? this.formSubmissionStatus,
    );
  }
}
