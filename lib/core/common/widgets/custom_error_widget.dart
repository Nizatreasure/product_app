import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:product_app/core/values/asset_manager.dart';
import 'package:product_app/core/values/string_manager.dart';

import 'custom_button.dart';

class CustomErrorWidget extends StatelessWidget {
  final void Function() onTap;
  final Size? buttonSize;
  final Size? errorImageSize;
  const CustomErrorWidget({
    super.key,
    required this.onTap,
    this.errorImageSize,
    this.buttonSize,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            SvgPicture.asset(
              AppAssetManager.error,
              width: errorImageSize?.width.r ?? 242.r,
              height: errorImageSize?.height.r ?? 190.r,
            ),
            SizedBox(height: 24.h),
            CustomButton(
              text: StringManager.retry,
              onTap: onTap,
              width: buttonSize?.width.r ?? 150.r,
              height: buttonSize?.height.h ?? 40.h,
            ),
          ],
        ),
      ),
    );
  }
}
