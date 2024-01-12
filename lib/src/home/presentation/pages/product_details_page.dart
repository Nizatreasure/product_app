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
import 'package:product_app/src/home/presentation/blocs/product_details_bloc/product_detail_bloc.dart';

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
                ? Padding(
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 20.w),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20.h),
                          Text(
                            state.productDetails!.title,
                            style: themeData.textTheme.bodyMedium!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            state.productDetails!.category.toUpperCase(),
                            style: themeData.textTheme.bodyMedium!
                                .copyWith(color: themeData.disabledColor),
                          ),
                          SizedBox(height: 14.h),
                          _buildImage(themeData, state),
                          SizedBox(height: 20.h),
                          _buildDescription(themeData, state),
                          SizedBox(height: 3.h),
                        ],
                      ),
                    ),
                  )
                : const CustomLoadingIndicator();
      }),
    );
  }
}
