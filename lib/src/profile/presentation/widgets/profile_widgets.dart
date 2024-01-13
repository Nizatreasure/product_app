part of '../pages/profile_page.dart';

Widget _profileButton({
  required String imagePath,
  required String title,
  required ThemeData themeData,
  void Function()? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 54,
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      margin: EdgeInsetsDirectional.only(bottom: 15.h),
      child: Row(
        children: [
          SvgPicture.asset(imagePath, width: 24.r, height: 24.r),
          SizedBox(width: 14.w),
          Expanded(
            child: Text(
              title,
              style: themeData.textTheme.bodyMedium!.copyWith(
                  fontSize: FontSizeManager.f14, fontWeight: FontWeight.w600),
            ),
          ),
          SvgPicture.asset(AppAssetManager.arrowForward,
              width: 24.r, height: 24.r),
        ],
      ),
    ),
  );
}
