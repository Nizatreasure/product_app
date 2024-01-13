import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_app/core/common/form_submission/form_submission.dart';
import 'package:product_app/core/common/widgets/custom_app_bar.dart';
import 'package:product_app/core/common/widgets/custom_error_widget.dart';
import 'package:product_app/core/values/color_manager.dart';
import 'package:product_app/core/values/fontsize_manager.dart';
import 'package:product_app/core/values/string_manager.dart';
import 'package:product_app/src/home/data/data_sources/local_data_source.dart';
import 'package:product_app/src/home/presentation/blocs/product_list_bloc/product_list_bloc.dart';
import 'package:product_app/src/home/presentation/widgets/product_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    context.read<ProductListBloc>()
      ..add(ProductListResetStateEvent())
      ..add(ProductListGetProductsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: customAppBar(
        context,
        title: StringManager.home,
        showBackButton: false,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
              StringManager.category,
              style: themeData.textTheme.bodyMedium!.copyWith(
                  fontSize: FontSizeManager.f16, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            height: 100.h,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            color: ColorManager.orange.withOpacity(0.06),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: ProductLocalDateSource.categories
                  .map((e) => _buildCategoryContainer(themeData,
                      assetName: e.imagePath, categoryTitle: e.categoryName))
                  .toList(),
            ),
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
              StringManager.products,
              style: themeData.textTheme.bodyMedium!.copyWith(
                  fontSize: FontSizeManager.f16, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(height: 5.h),
          Expanded(
            child: Builder(builder: (context) {
              return BlocBuilder<ProductListBloc, ProductListState>(
                  builder: (context, state) {
                return state.formSubmissionStatus is! SubmissionFailure
                    ? _customRefreshIndicator(
                        onRefresh: () async {
                          context
                              .read<ProductListBloc>()
                              .add(ProductListGetProductsEvent());
                        },
                        state: state,
                        child: ListView.builder(
                          itemCount: state.products?.length,
                          key: const PageStorageKey('product-list'),
                          padding: EdgeInsetsDirectional.fromSTEB(
                              20.w, 12.h, 20.w, 10.h),
                          itemBuilder: (_, index) {
                            return ProductItem(
                                productModel: state.products?[index]);
                          },
                        ),
                      )
                    : CustomErrorWidget(
                        onTap: () {
                          context
                              .read<ProductListBloc>()
                              .add(ProductListGetProductsEvent());
                        },
                      );
              });
            }),
          ),
        ],
      ),
    );
  }

  Widget _customRefreshIndicator(
      {required Widget child,
      required ProductListState state,
      required Future<void> Function() onRefresh}) {
    return state.formSubmissionStatus is SubmissionSuccess
        ? RefreshIndicator(
            onRefresh: onRefresh,
            backgroundColor: ColorManager.white,
            color: ColorManager.orange,
            child: child,
          )
        : child;
  }

  @override
  bool get wantKeepAlive => true;
}

Widget _buildCategoryContainer(ThemeData themeData,
    {required String assetName, required String categoryTitle}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Stack(
        children: [
          Container(
            width: 60.r,
            height: 60.r,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Image.asset(assetName, fit: BoxFit.cover),
          ),
          Container(
            width: 60.r,
            height: 60.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: themeData.canvasColor, width: 4),
            ),
          ),
        ],
      ),
      SizedBox(height: 2.h),
      Text(categoryTitle, style: themeData.textTheme.bodyMedium),
    ],
  );
}
