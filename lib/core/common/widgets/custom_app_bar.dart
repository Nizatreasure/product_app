import 'package:flutter/material.dart';
import 'package:product_app/core/common/widgets/custom_page_header.dart';

AppBar customAppBar(
  BuildContext context, {
  required String title,
  bool showBackButton = true,
  void Function()? onBackButtonPressed,
  bool centerTitle = false,
}) {
  ThemeData themeData = Theme.of(context);
  return AppBar(
    elevation: 0,
    automaticallyImplyLeading: false,
    backgroundColor: themeData.scaffoldBackgroundColor,
    surfaceTintColor: Colors.transparent,
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(0),
      child: CustomPageHeader(
        title,
        centerTitle: centerTitle,
        showBackButton: showBackButton,
        onBackButtonPressed: onBackButtonPressed,
      ),
    ),
  );
}
