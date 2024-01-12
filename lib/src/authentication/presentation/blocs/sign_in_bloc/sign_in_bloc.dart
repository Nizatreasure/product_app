import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/common/form_submission/form_submission.dart';

part 'sign_in_events.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  // final SignInUseCase _signInUseCase;
  // final LoginWithProviderUseCase _loginWithProviderUseCase;
  // SignInBloc(this._signInUseCase, this._loginWithProviderUseCase)
  SignInBloc() : super(const SignInState()) {
    on<SignInEmailChangedEvent>(_emailChangedEventHandler);
    on<SignInPasswordChangedEvent>(_passwordChangedEventHandler);
    on<SignInTogglePasswordVisibility>(_passwordVisibilityChangedEventHandler);
    on<SignInSubmittedEvent>(_signInEventHandler);
    on<ResetSignInStateEvent>(_resetStateEventHandler);
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

  void _signInEventHandler(SignInEvent event, Emitter<SignInState> emit) async {
    emit(state.copyWith(
      formSubmissionStatus: SubmittingForm(),
      showPassword: false,
    ));
    // CustomLoader.showLoader();
    // final dataState = await _signInUseCase.execute(params: {
    //   'email': state.email,
    //   'password': state.password,
    //   'first_name': state.firstName,
    //   'last_name': state.lastName,
    //   'phone_number': state.phoneNumber,
    //   'password_confirmation': state.password,
    // });
    // CustomLoader.dismissLoader();
    // if (dataState.isRight) {
    //   emit(state.copyWith(
    //       formSubmissionStatus:
    //           SubmissionSuccess<AuthEntity>(dataState.right)));
    // } else {
    //   emit(state.copyWith(
    //       formSubmissionStatus: SubmissionFailure(dataState.left)));
    // }
    emit(state.copyWith(formSubmissionStatus: const InitialFormStatus()));
  }
}
