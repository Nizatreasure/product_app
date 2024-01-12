import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_app/src/home/presentation/blocs/product_list_bloc/product_list_bloc.dart';

import 'di.dart';

class AppBlocs {
  static final _blocs = [
    BlocProvider<ProductListBloc>(create: (_) => getIt()),
  ];
  static get blocs => _blocs;
}
