import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:product_app/src/home/data/models/comment_model.dart';

class ProductReviewWidget extends StatelessWidget {
  final CommentModel comment;
  final bool showDivider;
  const ProductReviewWidget({
    super.key,
    required this.comment,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                comment.comment,
                style: themeData.textTheme.bodyMedium,
              ),
            ),
            SizedBox(width: 15.w),
            Text(DateFormat.yMd().format(comment.date))
          ],
        ),
        SizedBox(height: 10.h),
        Text(
          'by ${comment.commenter}',
          style: themeData.textTheme.bodyMedium!
              .copyWith(color: themeData.disabledColor),
        ),
        if (showDivider)
          Divider(
            height: 20.h,
            color: themeData.disabledColor.withOpacity(0.6),
            thickness: 0.2,
          )
        else
          SizedBox(height: 10.h),
      ],
    );
  }
}
