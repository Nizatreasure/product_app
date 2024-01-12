part of 'sign_up_bloc.dart';

abstract class SignUpEvent {
  const SignUpEvent();
}

class SignUpNameChangedEvent extends SignUpEvent {
  final String name;
  const SignUpNameChangedEvent(this.name);
}

class SignUpEmailChangedEvent extends SignUpEvent {
  final String email;
  const SignUpEmailChangedEvent(this.email);
}

class SignUpPasswordChangedEvent extends SignUpEvent {
  final String password;
  const SignUpPasswordChangedEvent(this.password);
}

class SignUpTogglePasswordVisibility extends SignUpEvent {
  final bool isVisible;
  const SignUpTogglePasswordVisibility(this.isVisible);
}

class SignUpSubmittedEvent extends SignUpEvent {}

class ResetSignUpStateEvent extends SignUpEvent {}
