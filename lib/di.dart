import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:product_app/src/authentication/domain/usecases/sign_in_usecase.dart';
import 'package:product_app/src/home/data/data_sources/remote_data_sources.dart';
import 'package:product_app/src/home/domain/usecases/product_list_usecase.dart';
import 'package:product_app/src/home/domain/usecases/single_product_usecase.dart';
import 'package:product_app/src/home/presentation/blocs/product_details_bloc/product_detail_bloc.dart';
import 'package:product_app/src/home/presentation/blocs/product_list_bloc/product_list_bloc.dart';
import 'package:product_app/src/landing/presentation/blocs/landing_bloc.dart';
import 'package:product_app/src/profile/presentation/blocs/account_info_bloc/account_info_bloc.dart';

import 'core/common/network/connection_checker.dart';
import 'core/services/network_request_service.dart';
import 'src/authentication/data/repositories/auth_repository_impl.dart';
import 'src/authentication/domain/usecases/sign_out_usecase.dart';
import 'src/authentication/domain/usecases/sign_up_usecase.dart';
import 'src/authentication/presentation/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'src/authentication/presentation/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'src/home/data/data_sources/remote/product_api_service.dart';
import 'src/home/data/repositories/product_repository_impl.dart';

final getIt = GetIt.instance;

Future<void> initializaDependencies() async {
  //dio
  BaseOptions options = BaseOptions(
    connectTimeout: const Duration(seconds: 15),
    sendTimeout: const Duration(seconds: 25),
    receiveTimeout: const Duration(seconds: 40),
  );
  Dio dio = Dio(options);
  getIt.registerLazySingleton<Dio>(() => dio);

  //services
  getIt.registerSingleton<InternetConnectionChecker>(
      InternetConnectionChecker());
  getIt.registerSingleton<ConnectionChecker>(ConnectionCheckerImpl(getIt()));
  getIt
      .registerSingleton<NetworkRequestService>(NetworkRequestService(getIt()));
  getIt.registerSingleton<ProductApiService>(ProductApiService(getIt()));

  //data sources
  getIt.registerSingleton<ProductsRemoteDataSource>(
      ProductsRemoteDataSourceImpl(getIt()));

  //repository
  getIt.registerSingleton<AuthenticationRepository>(
      AuthenticationRepositoryImpl(getIt()));
  getIt.registerSingleton<ProductsRepository>(
      ProductRepositoryImpl(getIt(), getIt()));

  //usecase
  getIt.registerSingleton<SignInUseCase>(SignInUseCase(getIt()));
  getIt.registerSingleton<SignUpUseCase>(SignUpUseCase(getIt()));
  getIt.registerSingleton<SignOutUseCase>(SignOutUseCase(getIt()));
  getIt.registerSingleton<ProductListUseCase>(ProductListUseCase(getIt()));
  getIt.registerSingleton<ProductSingleUseCase>(ProductSingleUseCase(getIt()));

  //blocs
  getIt.registerFactory<SignUpBloc>(() => SignUpBloc(getIt()));
  getIt.registerFactory<SignInBloc>(() => SignInBloc(getIt(), getIt()));
  getIt.registerFactory<LandingBloc>(() => LandingBloc());
  getIt.registerFactory<ProductListBloc>(() => ProductListBloc(getIt()));
  getIt.registerFactory<ProductDetailBloc>(() => ProductDetailBloc(getIt()));
  getIt.registerFactory<AccountInfoBloc>(() => AccountInfoBloc());
  // getIt.registerFactory<KycVerificationBloc>(() => KycVerificationBloc());
  // getIt.registerFactory<EnterEmailBloc>(() => EnterEmailBloc());
}
