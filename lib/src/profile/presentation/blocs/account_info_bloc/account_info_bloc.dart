import 'package:email_validator/email_validator.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'account_info_events.dart';
part 'account_info_state.dart';

class AccountInfoBloc extends Bloc<AccountInfoEvent, AccountInfoState> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;

  TextEditingController get nameController => _nameController;
  TextEditingController get emailController => _emailController;

  AccountInfoBloc() : super(const AccountInfoState()) {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    on<AccountInfoNameChangedEvent>(_accountNameChangedEventHandler);
    on<AccountInfoEmailChangedEvent>(_accountEmailChangedEventHandler);
    on<AccountInfoSetDataEvent>(_accountSetDataEvent);
    on<AccountInfoImagePathChangedEvent>(_accountImagePathChangedEventHandler);
    on<AccountInfoSubmittedEvent>(_submittedEventHandler);
  }

  _accountNameChangedEventHandler(
      AccountInfoNameChangedEvent event, Emitter<AccountInfoState> emit) {
    emit(state.copyWith(name: event.name));
  }

  _accountEmailChangedEventHandler(
      AccountInfoEmailChangedEvent event, Emitter<AccountInfoState> emit) {
    emit(state.copyWith(email: event.email));
  }

  _accountImagePathChangedEventHandler(
      AccountInfoImagePathChangedEvent event, Emitter<AccountInfoState> emit) {
    emit(state.copyWith(profileImagePath: event.path));
  }

  _accountSetDataEvent(
      AccountInfoSetDataEvent event, Emitter<AccountInfoState> emit) {
    _emailController.text = event.email;
    _nameController.text = event.name;
    emit(state.copyWith(email: event.email, name: event.name));
  }

  _submittedEventHandler(
      AccountInfoSubmittedEvent event, Emitter<AccountInfoState> emit) {}
}
