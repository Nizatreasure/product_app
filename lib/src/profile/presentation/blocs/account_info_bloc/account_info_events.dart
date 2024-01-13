part of 'account_info_bloc.dart';

abstract class AccountInfoEvent {
  const AccountInfoEvent();
}

class AccountInfoNameChangedEvent extends AccountInfoEvent {
  final String name;
  const AccountInfoNameChangedEvent(this.name);
}

class AccountInfoEmailChangedEvent extends AccountInfoEvent {
  final String email;
  const AccountInfoEmailChangedEvent(this.email);
}

class AccountInfoImagePathChangedEvent extends AccountInfoEvent {
  final String path;
  const AccountInfoImagePathChangedEvent(this.path);
}

class AccountInfoSetDataEvent extends AccountInfoEvent {
  final String name;
  final String email;
  const AccountInfoSetDataEvent({required this.name, required this.email});
}

class AccountInfoSubmittedEvent extends AccountInfoEvent {
  final String? password;
  final String? email;
  final String? name;
  final String? imagePath;
  const AccountInfoSubmittedEvent(
      {required this.password,
      required this.email,
      required this.name,
      required this.imagePath});
}
