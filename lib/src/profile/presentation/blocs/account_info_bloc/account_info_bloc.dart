import 'package:email_validator/email_validator.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_app/core/common/form_submission/form_submission.dart';
import 'package:product_app/core/common/widgets/custom_loader.dart';
import 'package:product_app/src/authentication/domain/usecases/sign_in_usecase.dart';
import 'package:product_app/src/profile/domain/usecases/account_info_usecase.dart';

part 'account_info_events.dart';
part 'account_info_state.dart';

class AccountInfoBloc extends Bloc<AccountInfoEvent, AccountInfoState> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;

  TextEditingController get nameController => _nameController;
  TextEditingController get emailController => _emailController;

  final AccountInfoUseCase _accountInfoUseCase;
  final SignInUseCase _signInUseCase;

  AccountInfoBloc(this._accountInfoUseCase, this._signInUseCase)
      : super(const AccountInfoState()) {
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
      AccountInfoSubmittedEvent event, Emitter<AccountInfoState> emit) async {
    CustomLoader.showLoader();
    if (event.password != null) {
      final dataState = await _signInUseCase
          .execute(params: {'email': event.email, 'password': event.password});

      if (dataState.isLeft) {
        emit(state.copyWith(
            formSubmissionStatus: SubmissionFailure(dataState.left)));
        CustomLoader.dismissLoader();
        return;
      }
    }
    final dataState2 = await _accountInfoUseCase.execute(params: {
      if (state.email != event.email) 'email': state.email,
      if (state.name != event.name) 'name': state.name,
      if (state.profileImagePath != event.imagePath)
        'imagePath': state.profileImagePath,
    });
    CustomLoader.dismissLoader();
    if (dataState2.isRight) {
      emit(state.copyWith(
          formSubmissionStatus: SubmissionSuccess(dataState2.right)));
    } else {
      emit(state.copyWith(
          formSubmissionStatus: SubmissionFailure(dataState2.left)));
    }
    emit(state.copyWith(formSubmissionStatus: const InitialFormStatus()));
  }
}
