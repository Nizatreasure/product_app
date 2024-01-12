import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CustomBackButton extends StatelessWidget {
  final void Function()? onTap;
  final double buttonSize;
  const CustomBackButton({this.onTap, this.buttonSize = 16, super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
          return;
        }
        context.pop();
      },
      child: Container(
        margin: EdgeInsetsDirectional.only(start: 15.w),
        padding: EdgeInsets.all(7.r),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xfff7e7d7).withOpacity(0.38),
        ),
        child: Icon(
          Icons.arrow_back_ios_rounded,
          color: themeData.canvasColor,
          size: buttonSize.r,
        ),
      ),
    );
  }
}
