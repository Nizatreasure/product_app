import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_app/core/values/fontsize_manager.dart';

import '../../values/color_manager.dart';

class CustomButton extends StatefulWidget {
  final void Function()? onTap;
  final double? width;
  final String text;
  final double? radius;
  final double height;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final double? textFontSize;
  final FontWeight? textFontWeight;
  final AlignmentGeometry textAlignment;
  final bool showDisabledState;
  const CustomButton({
    this.onTap,
    this.width,
    required this.text,
    this.height = 45,
    this.radius,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.textFontSize,
    this.textFontWeight,
    this.textAlignment = AlignmentDirectional.center,
    this.showDisabledState = true,
    super.key,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Align(
      alignment: AlignmentDirectional.center,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          height: widget.height.h,
          width: widget.width?.w ?? double.infinity,
          alignment: widget.textAlignment,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.radius?.r ?? 10.r),
            border: Border.all(
                color: widget.borderColor ?? ColorManager.transparent),
            color: widget.showDisabledState && widget.onTap == null
                ? themeData.canvasColor.withOpacity(0.3)
                : widget.backgroundColor ?? themeData.canvasColor,
          ),
          child: Text(
            widget.text,
            style: themeData.textTheme.bodyMedium!.copyWith(
              color: widget.textColor ?? ColorManager.white,
              fontSize: widget.textFontSize ?? FontSizeManager.f16,
              fontWeight: widget.textFontWeight,
            ),
          ),
        ),
      ),
    );
  }
}
