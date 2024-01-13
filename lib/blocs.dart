import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_app/src/authentication/presentation/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:product_app/src/authentication/presentation/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:product_app/src/home/presentation/blocs/product_list_bloc/product_list_bloc.dart';

import 'di.dart';
import 'src/home/presentation/blocs/product_details_bloc/product_detail_bloc.dart';

class AppBlocs {
  static final _blocs = [
    BlocProvider<SignUpBloc>(create: (_) => getIt()),
    BlocProvider<SignInBloc>(create: (_) => getIt()),
    BlocProvider<ProductListBloc>(create: (_) => getIt()),
    BlocProvider<ProductDetailBloc>(create: (_) => getIt()),
  ];
  static get blocs => _blocs;
}
