import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_back_button.dart';

class CustomPageHeader extends StatelessWidget {
  final String title;
  final bool showBackButton;
  final void Function()? onBackButtonPressed;
  final bool centerTitle;
  const CustomPageHeader(
    this.title, {
    this.showBackButton = true,
    this.centerTitle = false,
    this.onBackButtonPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: 0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 38.r,
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 60),
            alignment: AlignmentDirectional.center,
            child: Row(
              mainAxisAlignment: centerTitle
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsetsDirectional.only(start: centerTitle ? 0 : 20.w),
                  child: Text(
                    title,
                    style: themeData.textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
          ),
          if (showBackButton)
            PositionedDirectional(
              start: 0,
              child: CustomBackButton(
                onTap: onBackButtonPressed,
              ),
            ),
        ],
      ),
    );
  }
}
