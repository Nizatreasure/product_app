import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:product_app/core/common/widgets/custom_text_input_field.dart';
import 'package:product_app/core/values/color_manager.dart';

import '../../values/string_manager.dart';
import 'custom_button.dart';

Future<bool> showCustomDialog(
  BuildContext context, {
  required String title,
  required String body,
  required String confirmButtonText,
  bool canPop = true,
  bool showCancelButton = false,
  String cancelButtonText = StringManager.cancel,
  TextEditingController? controller,
}) async {
  bool? returnValue = await showDialog(
    context: context,
    barrierDismissible: canPop,
    useRootNavigator: true,
    builder: (context) {
      return CustomDialog(
        canPop: canPop,
        title: title,
        body: body,
        showCancelButton: showCancelButton,
        cancelButtonText: cancelButtonText,
        confirmButtonText: confirmButtonText,
        controller: controller,
      );
    },
  );
  return returnValue == true;
}

class CustomDialog extends StatefulWidget {
  final bool canPop;
  final String title;
  final String body;
  final bool showCancelButton;
  final String cancelButtonText;
  final String confirmButtonText;
  final TextEditingController? controller;
  const CustomDialog({
    super.key,
    required this.canPop,
    required this.title,
    required this.body,
    required this.showCancelButton,
    required this.cancelButtonText,
    required this.confirmButtonText,
    required this.controller,
  });

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return PopScope(
      canPop: widget.canPop,
      child: Dialog(
        elevation: 30.r,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 18.h),
          decoration: BoxDecoration(
            color: ColorManager.tintOrange,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.title,
                style: themeData.textTheme.bodyLarge!
                    .copyWith(color: ColorManager.black),
              ),
              SizedBox(height: 8.h),
              Text(
                widget.body,
                style: themeData.textTheme.bodyMedium!
                    .copyWith(color: ColorManager.black),
                textAlign: TextAlign.center,
              ),
              if (widget.controller != null)
                Padding(
                  padding: EdgeInsetsDirectional.only(top: 20.h),
                  child: CustomTextInputField(
                    hintText: StringManager.enterPassword,
                    textEditingController: widget.controller!,
                    obscuringCharacter: '●',
                  ),
                ),
              SizedBox(height: 40.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    text: widget.confirmButtonText,
                    width: widget.showCancelButton ? 100 : 150,
                    onTap: () => context.pop(true),
                    height: 40,
                  ),
                  if (widget.showCancelButton)
                    Padding(
                      padding: EdgeInsetsDirectional.only(start: 24.w),
                      child: CustomButton(
                        text: widget.cancelButtonText,
                        width: 100,
                        height: 40,
                        onTap: () => context.pop(false),
                        backgroundColor: Colors.transparent,
                        borderColor: themeData.canvasColor,
                        textColor: themeData.canvasColor,
                      ),
                    ),
                ],
              ),
              SizedBox(height: 30.h)
            ],
          ),
        ),
      ),
    );
  }
}
