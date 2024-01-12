import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_app/core/common/form_submission/form_submission.dart';
import 'package:product_app/core/common/widgets/custom_app_bar.dart';
import 'package:product_app/core/values/string_manager.dart';
import 'package:product_app/src/home/presentation/blocs/product_list_bloc/product_list_bloc.dart';
import 'package:product_app/src/home/presentation/widgets/product_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<ProductListBloc>().add(ProductListGetProductsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
        title: StringManager.home,
        showBackButton: false,
        centerTitle: true,
      ),
      body: Builder(builder: (context) {
        return BlocBuilder<ProductListBloc, ProductListState>(
            builder: (context, state) {
          return state.formSubmissionStatus is! SubmissionFailure
              ? ListView.builder(
                  itemCount: state.products?.length,
                  padding:
                      EdgeInsetsDirectional.fromSTEB(20.w, 12.h, 20.w, 10.h),
                  itemBuilder: (_, index) {
                    return ProductItem(productModel: state.products?[index]);
                  },
                )
              : Text('Failed');
        });
      }),
    );
  }
}
