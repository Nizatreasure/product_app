import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_app/core/common/user_data.dart';
import 'package:product_app/core/common/widgets/custom_loader.dart';
import 'package:product_app/src/authentication/domain/usecases/sign_in_usecase.dart';
import 'package:product_app/src/authentication/domain/usecases/sign_out_usecase.dart';

import '../../../../../core/common/form_submission/form_submission.dart';

part 'sign_in_events.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final SignInUseCase _signInUseCase;
  final SignOutUseCase _signOutUseCase;

  SignInBloc(this._signInUseCase, this._signOutUseCase)
      : super(const SignInState()) {
    on<SignInEmailChangedEvent>(_emailChangedEventHandler);
    on<SignInPasswordChangedEvent>(_passwordChangedEventHandler);
    on<SignInTogglePasswordVisibility>(_passwordVisibilityChangedEventHandler);
    on<SignInSubmittedEvent>(_signInEventHandler);
    on<ResetSignInStateEvent>(_resetStateEventHandler);
    on<SignOutSubmittedEvent>(_signOutEventHandler);
    on<SignInToggleRememberMeEvent>(_toggleRememberMeEventHandler);
  }

  void _resetStateEventHandler(
      ResetSignInStateEvent event, Emitter<SignInState> emit) {
    emit(const SignInState());
  }

  void _emailChangedEventHandler(
      SignInEmailChangedEvent event, Emitter<SignInState> emit) {
    String email = event.email;
    emit(state.copyWith(email: email));
  }

  void _passwordChangedEventHandler(
      SignInPasswordChangedEvent event, Emitter<SignInState> emit) {
    String password = event.password;
    emit(state.copyWith(password: password));
  }

  void _passwordVisibilityChangedEventHandler(
      SignInTogglePasswordVisibility event, Emitter<SignInState> emit) {
    emit(state.copyWith(showPassword: event.isVisible));
  }

  void _toggleRememberMeEventHandler(
      SignInToggleRememberMeEvent event, Emitter<SignInState> emit) {
    UserData.rememberMe = event.rememberMe;
    emit(state.copyWith(rememberMe: event.rememberMe));
  }

  void _signInEventHandler(SignInEvent event, Emitter<SignInState> emit) async {
    emit(state.copyWith(
      formSubmissionStatus: SubmittingForm(),
      showPassword: false,
    ));
    CustomLoader.showLoader();
    final dataState = await _signInUseCase.execute(params: {
      'email': state.email,
      'password': state.password,
    });
    CustomLoader.dismissLoader();
    if (dataState.isRight) {
      UserData.email = state.rememberMe ? state.email : '';

      emit(state.copyWith(
          formSubmissionStatus:
              SubmissionSuccess<UserCredential>(dataState.right)));
    } else {
      emit(state.copyWith(
          formSubmissionStatus: SubmissionFailure(dataState.left)));
    }
    emit(state.copyWith(formSubmissionStatus: const InitialFormStatus()));
  }

  void _signOutEventHandler(
      SignOutSubmittedEvent event, Emitter<SignInState> emit) async {
    await _signOutUseCase.execute(params: null);
    emit(state.copyWith(logoutFormSubmissionStatus: SubmissionSuccess('')));
    emit(state.copyWith(logoutFormSubmissionStatus: const InitialFormStatus()));
  }
}
