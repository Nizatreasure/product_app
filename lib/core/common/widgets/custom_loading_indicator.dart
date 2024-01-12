import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Center(
      heightFactor: 0.9,
      child: SpinKitFoldingCube(
        size: 50.r,
        itemBuilder: (context, index) {
          return DecoratedBox(
            decoration: const BoxDecoration(),
            child: Container(
              margin: EdgeInsetsDirectional.all(1.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3.r),
                border: Border.all(
                  color: index % 2 == 0
                      ? themeData.textTheme.bodyMedium!.color!
                      : themeData.canvasColor,
                  width: 5.r,
                ),
                color: index % 2 == 0
                    ? themeData.canvasColor
                    : themeData.textTheme.bodyMedium!.color,
              ),
            ),
          );
        },
      ),
    );
  }
}
