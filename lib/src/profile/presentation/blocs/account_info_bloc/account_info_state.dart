part of 'account_info_bloc.dart';

@immutable
class AccountInfoState {
  final String name;
  final String email;
  final String profileImagePath;

  final FormSubmissionStatus formSubmissionStatus;

  bool get isValid => name.trim().length >= 5 && EmailValidator.validate(email);

  const AccountInfoState({
    this.name = '',
    this.email = '',
    this.profileImagePath = '',
    this.formSubmissionStatus = const InitialFormStatus(),
  });

  AccountInfoState copyWith(
      {String? name,
      String? email,
      String? profileImagePath,
      FormSubmissionStatus? formSubmissionStatus}) {
    return AccountInfoState(
      name: name ?? this.name,
      email: email ?? this.email,
      profileImagePath: profileImagePath ?? this.profileImagePath,
      formSubmissionStatus: formSubmissionStatus ?? this.formSubmissionStatus,
    );
  }
}
