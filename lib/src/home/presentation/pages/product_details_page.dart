import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:product_app/core/common/widgets/custom_app_bar.dart';
import 'package:product_app/core/values/asset_manager.dart';
import 'package:product_app/core/values/color_manager.dart';
import 'package:product_app/core/values/fontsize_manager.dart';
import 'package:product_app/core/values/string_manager.dart';

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
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: customAppBar(context, title: StringManager.productDetails),
      body: Padding(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Text(
                'Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops',
                style: themeData.textTheme.bodyMedium!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              Text(
                'Category: Mens clothing',
                style: themeData.textTheme.bodyMedium!
                    .copyWith(color: themeData.disabledColor),
              ),
              SizedBox(height: 14.h),
              _buildImage(themeData),
              SizedBox(height: 10.h),
              _buildDescription(themeData),
              SizedBox(height: 3.h),
            ],
          ),
        ),
      ),
    );
  }
}
