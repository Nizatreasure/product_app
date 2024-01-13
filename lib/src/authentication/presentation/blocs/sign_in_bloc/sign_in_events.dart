part of 'sign_in_bloc.dart';

abstract class SignInEvent {
  const SignInEvent();
}

class SignInEmailChangedEvent extends SignInEvent {
  final String email;
  const SignInEmailChangedEvent(this.email);
}

class SignInPasswordChangedEvent extends SignInEvent {
  final String password;
  const SignInPasswordChangedEvent(this.password);
}

class SignInTogglePasswordVisibility extends SignInEvent {
  final bool isVisible;
  const SignInTogglePasswordVisibility(this.isVisible);
}

class SignInToggleRememberMeEvent extends SignInEvent {
  final bool rememberMe;
  const SignInToggleRememberMeEvent(this.rememberMe);
}

class SignInSubmittedEvent extends SignInEvent {}

class SignOutSubmittedEvent extends SignInEvent {}

class ResetSignInStateEvent extends SignInEvent {}
