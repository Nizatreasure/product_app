import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_app/core/values/fontsize_manager.dart';

class CustomTextInputField extends StatefulWidget {
  final String hintText;
  final TextEditingController? textEditingController;

  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final List<TextInputFormatter> inputFormatters;
  final int? maxLength;
  final TextCapitalization textCapitalization;
  final String? fieldName;
  final TextInputType keyboardType;
  final bool useFixHeight;
  final int? maxLines;
  final int? minLines;
  final EdgeInsetsGeometry? contentPadding;
  final TextAlign? textAlign;
  final TextAlignVertical? textAlignVertical;
  final bool readOnly;
  final void Function()? onTap;
  final double borderRadius;
  const CustomTextInputField({
    super.key,
    required this.hintText,
    this.readOnly = false,
    this.onTap,
    this.textEditingController,
    this.onChanged,
    this.validator,
    this.inputFormatters = const [],
    this.maxLength,
    this.textCapitalization = TextCapitalization.sentences,
    this.textAlignVertical = TextAlignVertical.bottom,
    this.keyboardType = TextInputType.text,
    this.fieldName,
    this.useFixHeight = true,
    this.maxLines = 1,
    this.minLines,
    this.contentPadding,
    this.textAlign,
    this.borderRadius = 10,
  });

  @override
  State<CustomTextInputField> createState() => _CustomTextInputFieldState();
}

class _CustomTextInputFieldState extends State<CustomTextInputField> {
  late final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_focusNodeListener);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_focusNodeListener);
    super.dispose();
  }

  _focusNodeListener() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return PopScope(
      canPop: !_focusNode.hasFocus,
      onPopInvoked: (didPop) {
        if (!didPop) {
          _focusNode.unfocus();
        }
      },
      child: Padding(
        padding: EdgeInsetsDirectional.only(bottom: 15.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 4.h),
              child: widget.fieldName != null
                  ? Text(
                      ' ${widget.fieldName!}',
                      style: themeData.textTheme.bodyMedium!
                          .copyWith(fontSize: FontSizeManager.f14),
                    )
                  : const SizedBox(),
            ),
            SizedBox(
              height: widget.maxLines == 1 ? 40.h : null,
              child: TextFormField(
                keyboardType: widget.keyboardType,
                maxLines: widget.maxLines,
                minLines: widget.minLines,
                readOnly: widget.readOnly,
                focusNode: _focusNode,
                decoration: InputDecoration(
                  contentPadding: widget.contentPadding,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: themeData.canvasColor,
                      width: 0.5.r,
                    ),
                    borderRadius: BorderRadius.circular(widget.borderRadius.r),
                  ),
                  fillColor: themeData.dialogBackgroundColor,
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: themeData.colorScheme.error,
                      width: 0.5.r,
                    ),
                    borderRadius: BorderRadius.circular(widget.borderRadius.r),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: themeData.colorScheme.error,
                      width: 0.5.r,
                    ),
                    borderRadius: BorderRadius.circular(widget.borderRadius.r),
                  ),
                  filled: true,
                  prefixIcon: Container(),
                  prefixIconConstraints: BoxConstraints(maxWidth: 14.r),
                  suffixIconConstraints: BoxConstraints(maxWidth: 30.r),
                  hintStyle: themeData.textTheme.bodyMedium!.copyWith(
                      color: themeData.disabledColor,
                      fontSize: FontSizeManager.f10),
                  hintText: widget.hintText,
                  counterText: '',
                ),
                onTap: widget.onTap,
                textCapitalization: widget.textCapitalization,
                textAlignVertical: widget.textAlignVertical,
                autovalidateMode: AutovalidateMode.disabled,
                inputFormatters: widget.inputFormatters,
                textAlign: widget.textAlign ?? TextAlign.start,
                maxLength: widget.maxLength,
                controller: widget.textEditingController,
                cursorColor: themeData.textTheme.bodyMedium!.color!,
                style: themeData.textTheme.bodyMedium!.copyWith(
                  fontSize: FontSizeManager.f12,
                  color: themeData.textTheme.bodyMedium!.color,
                ),
                onChanged: widget.onChanged ??
                    (val) {
                      setState(() {});
                    },
                validator: widget.validator,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
