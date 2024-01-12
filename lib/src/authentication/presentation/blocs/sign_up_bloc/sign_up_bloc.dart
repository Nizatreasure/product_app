import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/common/form_submission/form_submission.dart';

part 'sign_up_events.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  // final SignUpUseCase _signUpUseCase;
  // final LoginWithProviderUseCase _loginWithProviderUseCase;
  // SignUpBloc(this._signUpUseCase, this._loginWithProviderUseCase)
  SignUpBloc() : super(const SignUpState()) {
    on<SignUpNameChangedEvent>(_nameChangedEventHandler);
    on<SignUpEmailChangedEvent>(_emailChangedEventHandler);
    on<SignUpPasswordChangedEvent>(_passwordChangedEventHandler);
    on<SignUpTogglePasswordVisibility>(_passwordVisibilityChangedEventHandler);
    on<SignUpSubmittedEvent>(_signUpEventHandler);
    on<ResetSignUpStateEvent>(_resetStateEventHandler);
  }

  void _resetStateEventHandler(
      ResetSignUpStateEvent event, Emitter<SignUpState> emit) {
    emit(const SignUpState());
  }

  void _nameChangedEventHandler(
      SignUpNameChangedEvent event, Emitter<SignUpState> emit) {
    String firstName = event.name;
    emit(state.copyWith(name: firstName));
  }

  void _emailChangedEventHandler(
      SignUpEmailChangedEvent event, Emitter<SignUpState> emit) {
    String email = event.email;
    emit(state.copyWith(email: email));
  }

  void _passwordChangedEventHandler(
      SignUpPasswordChangedEvent event, Emitter<SignUpState> emit) {
    String password = event.password;
    emit(state.copyWith(password: password));
  }

  void _passwordVisibilityChangedEventHandler(
      SignUpTogglePasswordVisibility event, Emitter<SignUpState> emit) {
    emit(state.copyWith(showPassword: event.isVisible));
  }

  void _signUpEventHandler(SignUpEvent event, Emitter<SignUpState> emit) async {
    emit(state.copyWith(
      formSubmissionStatus: SubmittingForm(),
      showPassword: false,
    ));
    // CustomLoader.showLoader();
    // final dataState = await _signUpUseCase.execute(params: {
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
