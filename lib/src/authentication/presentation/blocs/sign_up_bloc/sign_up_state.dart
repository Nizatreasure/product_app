part of 'sign_up_bloc.dart';

class SignUpState {
  final String name;
  final String email;
  final String password;
  final bool showPassword;

  bool get isValid =>
      name.trim().isNotEmpty &&
      email.trim().isNotEmpty &&
      password.trim().isNotEmpty;

  final FormSubmissionStatus formSubmissionStatus;

  const SignUpState({
    this.name = '',
    this.email = '',
    this.password = '',
    this.showPassword = false,
    this.formSubmissionStatus = const InitialFormStatus(),
  });

  SignUpState copyWith({
    String? name,
    String? email,
    String? password,
    bool? showPassword,
    FormSubmissionStatus? formSubmissionStatus,
  }) {
    return SignUpState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      showPassword: showPassword ?? this.showPassword,
      formSubmissionStatus: formSubmissionStatus ?? this.formSubmissionStatus,
    );
  }
}
