import 'package:get_it/get_it.dart';
import 'package:product_app/src/landing/presentation/blocs/landing_bloc.dart';

import 'src/authentication/presentation/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'src/authentication/presentation/blocs/sign_up_bloc/sign_up_bloc.dart';

final getIt = GetIt.instance;

Future<void> initializaDependencies() async {
  //services
  // getIt.registerSingleton<TimerService>(const TimerService());

  //blocs
  getIt.registerFactory<SignUpBloc>(() => SignUpBloc());
  getIt.registerFactory<SignInBloc>(() => SignInBloc());
  getIt.registerFactory<LandingBloc>(() => LandingBloc());
  // getIt.registerFactory<SignInBloc>(() => SignInBloc());
  // getIt.registerFactory<EmailVerificationBloc>(() => EmailVerificationBloc());
  // getIt.registerFactory<CreatePinBloc>(() => CreatePinBloc());
  // getIt.registerFactory<KycVerificationBloc>(() => KycVerificationBloc());
  // getIt.registerFactory<EnterEmailBloc>(() => EnterEmailBloc());
  // getIt.registerFactory<EnterOtpBloc>(() => EnterOtpBloc());
  // getIt.registerFactory<CreateNewPasswordBloc>(() => CreateNewPasswordBloc());
  // getIt.registerFactory<LandingBloc>(() => LandingBloc());
  // getIt.registerFactory<HomeBloc>(() => HomeBloc());
  // getIt.registerFactory<TransferGidiPayBloc>(() => TransferGidiPayBloc());
  // getIt.registerFactory<TransferOtherBanksBloc>(() => TransferOtherBanksBloc());
  // getIt.registerFactory<ElectricityBloc>(() => ElectricityBloc());
  // getIt.registerFactory<AirtimeBloc>(() => AirtimeBloc());
  // getIt.registerFactory<DataBloc>(() => DataBloc());
  // getIt.registerFactory<CardBloc>(() => CardBloc());
  // getIt.registerFactory<InternetBloc>(() => InternetBloc());
  // getIt.registerFactory<BettingBloc>(() => BettingBloc());
  // getIt.registerFactory<BeneficiaryBloc>(() => BeneficiaryBloc());
  // getIt.registerFactory<CableTvBloc>(() => CableTvBloc());
  // getIt.registerFactory<GiftUserBloc>(() => GiftUserBloc());
  // getIt.registerFactory<TicketBloc>(() => TicketBloc());
  // getIt.registerFactory<HistoryBloc>(() => HistoryBloc());
  // getIt.registerFactory<ChangePasswordBloc>(() => ChangePasswordBloc());
  // getIt.registerFactory<ChangePinBloc>(() => ChangePinBloc());
  // getIt.registerFactory<MakeAReportBloc>(() => MakeAReportBloc());
  // getIt.registerFactory<DeleteAccountBloc>(() => DeleteAccountBloc());
}
