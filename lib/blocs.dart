import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_app/src/home/presentation/blocs/product_list_bloc/product_list_bloc.dart';

import 'di.dart';
import 'src/home/presentation/blocs/product_details_bloc/product_detail_bloc.dart';

class AppBlocs {
  static final _blocs = [
    BlocProvider<ProductListBloc>(create: (_) => getIt()),
    BlocProvider<ProductDetailBloc>(create: (_) => getIt()),
  ];
  static get blocs => _blocs;
}
