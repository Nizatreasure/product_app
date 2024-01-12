import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_app/core/common/widgets/custom_app_bar.dart';
import 'package:product_app/core/values/string_manager.dart';
import 'package:product_app/src/home/presentation/widgets/product_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
        title: StringManager.home,
        showBackButton: false,
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: EdgeInsetsDirectional.fromSTEB(20.w, 12.h, 20.w, 10.h),
        itemBuilder: (context, index) {
          return ProductItem();
        },
      ),
    );
  }
}
