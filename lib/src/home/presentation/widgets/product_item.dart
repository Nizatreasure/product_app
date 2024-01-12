import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:product_app/core/routes/route_names.dart';
import 'package:product_app/core/values/asset_manager.dart';
import 'package:product_app/core/values/color_manager.dart';
import 'package:product_app/core/values/fontsize_manager.dart';
import 'package:product_app/src/home/data/models/product_model.dart';
import 'package:shimmer/shimmer.dart';

class ProductItem extends StatelessWidget {
  final ProductModel? productModel;
  const ProductItem({super.key, this.productModel});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return GestureDetector(
      onTap: () {
        context.pushNamed(RouteNames.productDetails);
      },
      child: Container(
        height: 100.h,
        margin: EdgeInsetsDirectional.only(bottom: 25.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: themeData.scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: ColorManager.black.withOpacity(0.1),
              blurRadius: 4,
              spreadRadius: 0,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: SizedBox(
                width: 100.h,
                height: 100.h,
                child: productModel == null
                    ? Container(color: ColorManager.tintOrange.withOpacity(0.5))
                    : CachedNetworkImage(
                        imageUrl: productModel!.image,
                        fit: BoxFit.cover,
                        placeholder: (context, url) {
                          return Container(
                              color: ColorManager.tintOrange.withOpacity(0.5));
                        },
                        errorWidget: (context, url, error) {
                          return Container(
                              color: ColorManager.tintOrange.withOpacity(0.5));
                        },
                      ),
              ),
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 12.h, 12.w, 12.h),
                child: productModel == null
                    ? _buildShimmer()
                    : _buildProdutDisplay(themeData),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProdutDisplay(ThemeData themeData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          productModel!.category.toUpperCase(),
          style: themeData.textTheme.bodyMedium!.copyWith(
              fontSize: FontSizeManager.f10, color: themeData.disabledColor),
        ),
        SizedBox(height: 5.h),
        SizedBox(
          height: 30.h,
          child: Text(
            productModel!.title,
            style: themeData.textTheme.bodyMedium!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Text('\$ ${productModel!.price}',
                style: themeData.textTheme.bodyMedium!),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SvgPicture.asset(AppAssetManager.star,
                      width: 18.r, height: 15.r),
                  SizedBox(width: 3.w),
                  Text(
                    '${productModel?.rating.rate}',
                    style: themeData.textTheme.bodyMedium!,
                  )
                ],
              ),
            ),
          ],
        )
      ],
    );
  }

  _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade200,
      highlightColor: Colors.grey.shade300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FractionallySizedBox(
            widthFactor: 0.6,
            child: Container(
              color: Colors.grey,
              width: double.infinity,
              height: 10,
            ),
          ),
          SizedBox(height: 10.h),
          Container(
            color: Colors.grey,
            width: double.infinity,
            height: 15,
          ),
          SizedBox(height: 10.h),
          FractionallySizedBox(
            widthFactor: 0.4,
            child: Container(
              color: Colors.grey,
              width: double.infinity,
              height: 10,
            ),
          ),
        ],
      ),
    );
  }
}
