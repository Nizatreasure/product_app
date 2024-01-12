import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:product_app/core/routes/route_names.dart';
import 'package:product_app/core/values/color_manager.dart';
import 'package:product_app/core/values/fontsize_manager.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

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
                child: CachedNetworkImage(
                  imageUrl: 'imageUrl',
                  fit: BoxFit.cover,
                  placeholder: (context, url) {
                    return Container(color: ColorManager.tintOrange);
                  },
                  errorWidget: (context, url, error) {
                    return Container(color: ColorManager.tintOrange);
                  },
                ),
              ),
            ),
            SizedBox(width: 30.w),
            Padding(
              padding: EdgeInsetsDirectional.symmetric(vertical: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Product title',
                    style: themeData.textTheme.bodyLarge!
                        .copyWith(fontSize: FontSizeManager.f14),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    'category',
                    style: themeData.textTheme.bodyMedium!.copyWith(
                        fontSize: FontSizeManager.f10,
                        color: themeData.disabledColor),
                  ),
                  SizedBox(height: 8.h),
                  Text('\$ 200', style: themeData.textTheme.bodyMedium!)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
