part of '../pages/favourite_page.dart';

_buildNoFavourites(ThemeData themeData) {
  return FractionallySizedBox(
    heightFactor: 0.84,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(AppAssetManager.favouriteEmpty,
            width: 200.r, height: 180.r),
        SizedBox(height: 24.h),
        Text(
          StringManager.noFavourite,
          textAlign: TextAlign.center,
          style: themeData.textTheme.bodyMedium!.copyWith(
              fontSize: FontSizeManager.f24, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 24.h),
        Text(
          StringManager.favouriteAdd,
          textAlign: TextAlign.center,
          style: themeData.textTheme.bodyMedium!
              .copyWith(fontSize: FontSizeManager.f14),
        ),
      ],
    ),
  );
}
