import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:product_app/core/values/asset_manager.dart';
import 'package:product_app/core/values/fontsize_manager.dart';
import 'package:product_app/core/values/string_manager.dart';

class CustomPasswordField extends StatelessWidget {
  final TextEditingController? textEditingController;

  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final String? fieldName;
  final void Function()? toggleVisibility;
  final bool showPassword;
  final String? hintText;
  final double borderRadius;

  const CustomPasswordField({
    super.key,
    this.textEditingController,
    required this.showPassword,
    required this.toggleVisibility,
    this.borderRadius = 10,
    this.hintText,
    this.onChanged,
    this.fieldName,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Padding(
      padding: EdgeInsetsDirectional.only(bottom: 15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.only(bottom: 4.h),
            child: Text(
              ' ${fieldName ?? StringManager.password}',
              style: themeData.textTheme.bodyMedium!
                  .copyWith(fontSize: FontSizeManager.f14),
            ),
          ),
          SizedBox(
            height: 40.h,
            child: TextFormField(
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                  hintText: hintText ?? StringManager.password,
                  enabledBorder: InputBorder.none,
                  border: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: themeData.canvasColor,
                      width: 0.5.r,
                    ),
                    borderRadius: BorderRadius.circular(borderRadius.r),
                  ),
                  fillColor: themeData.dialogBackgroundColor,
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: themeData.colorScheme.error,
                      width: 0.5.r,
                    ),
                    borderRadius: BorderRadius.circular(borderRadius.r),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: themeData.colorScheme.error,
                      width: 0.5.r,
                    ),
                    borderRadius: BorderRadius.circular(borderRadius.r),
                  ),
                  filled: true,
                  prefixIcon: Container(),
                  prefixIconConstraints: BoxConstraints(maxWidth: 14.r),
                  hintStyle: themeData.textTheme.bodyMedium!.copyWith(
                      color: themeData.disabledColor,
                      fontSize: FontSizeManager.f10),
                  suffixIcon: IconButton(
                    onPressed: toggleVisibility,
                    alignment: AlignmentDirectional.bottomCenter,
                    splashRadius: 1.r,
                    icon: Padding(
                      padding: EdgeInsets.all(showPassword ? 2 : 0),
                      child: SvgPicture.asset(
                        showPassword
                            ? AppAssetManager.eyeOpen
                            : AppAssetManager.eyeHide,
                        colorFilter: ColorFilter.mode(
                          themeData.disabledColor,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  suffixIconConstraints: BoxConstraints(minWidth: 50.r)),
              onChanged: onChanged,
              cursorColor: themeData.textTheme.bodyMedium!.color,
              obscureText: !showPassword,
              obscuringCharacter: '●',
              textAlignVertical: TextAlignVertical.bottom,
              autovalidateMode: AutovalidateMode.disabled,
              controller: textEditingController,
              style: themeData.textTheme.bodyMedium!.copyWith(
                color: themeData.textTheme.bodyMedium!.color,
              ),
              textCapitalization: TextCapitalization.none,
              validator: validator,
            ),
          ),
        ],
      ),
    );
  }
}
