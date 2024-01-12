import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart' as rw;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:product_app/core/common/form_submission/form_submission.dart';
import 'package:product_app/core/common/widgets/custom_app_bar.dart';
import 'package:product_app/core/common/widgets/custom_error_widget.dart';
import 'package:product_app/core/common/widgets/custom_loading_indicator.dart';
import 'package:product_app/core/values/asset_manager.dart';
import 'package:product_app/core/values/color_manager.dart';
import 'package:product_app/core/values/fontsize_manager.dart';
import 'package:product_app/core/values/string_manager.dart';
import 'package:product_app/src/home/data/data_sources/local_data_source.dart';
import 'package:product_app/src/home/presentation/blocs/product_details_bloc/product_detail_bloc.dart';
import 'package:product_app/src/home/presentation/pages/product_review_widget.dart';

part '../widgets/product_details_widgets.dart';

class ProductDetailsPage extends StatefulWidget {
  final int productId;
  const ProductDetailsPage({
    super.key,
    required this.productId,
  });

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  void initState() {
    super.initState();
    context
        .read<ProductDetailBloc>()
        .add(ProductDetailSetProductIdEvent(widget.productId));
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: customAppBar(context, title: StringManager.productDetails),
      body: BlocBuilder<ProductDetailBloc, ProductDetailState>(
          builder: (context, state) {
        return state.formSubmissionStatus is SubmissionFailure
            ? CustomErrorWidget(onTap: () {
                context
                    .read<ProductDetailBloc>()
                    .add(ProductDetailGetDetailsEvent());
              })
            : state.formSubmissionStatus is SubmissionSuccess
                ? SingleChildScrollView(
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h),
                        _buildTitleAndCategory(themeData, state),
                        SizedBox(height: 14.h),
                        _buildImage(themeData, state),
                        SizedBox(height: 20.h),
                        _buildDescription(themeData, state),
                        SizedBox(height: 15.h),
                        _buildSpecification(themeData),
                        SizedBox(height: 20.h),
                        Container(
                          margin: EdgeInsetsDirectional.only(bottom: 20.h),
                          padding: EdgeInsetsDirectional.fromSTEB(
                              15.w, 12.h, 15.w, 12.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: themeData.scaffoldBackgroundColor,
                            boxShadow: [
                              BoxShadow(
                                color: ColorManager.black.withOpacity(0.1),
                                spreadRadius: 0,
                                blurRadius: 4,
                                offset: const Offset(0, 0),
                              )
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                StringManager.reviews,
                                style: themeData.textTheme.bodyLarge!
                                    .copyWith(fontSize: FontSizeManager.f12),
                              ),
                              SizedBox(height: 20.h),
                              ...ProductLocalDateSource.comments
                                  .map((e) => ProductReviewWidget(
                                        comment: e,
                                        showDivider: e.commenter != 'Zod',
                                      ))
                                  .toList(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : const CustomLoadingIndicator();
      }),
    );
  }
}
