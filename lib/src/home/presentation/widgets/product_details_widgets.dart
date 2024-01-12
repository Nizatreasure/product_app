part of '../pages/product_details_page.dart';

Widget _buildImage(ThemeData themeData) {
  return Stack(
    children: [
      Container(
        height: 193.h,
        width: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: CachedNetworkImage(
          imageUrl: 'imageUrl',
          placeholder: (context, url) {
            return Container(color: ColorManager.tintOrange);
          },
          errorWidget: (context, url, error) {
            return Container(color: ColorManager.tintOrange);
          },
        ),
      ),
      PositionedDirectional(
        end: 3.r,
        top: 4.r,
        child: CircleAvatar(
          radius: 17,
          backgroundColor: themeData.scaffoldBackgroundColor,
          child: SvgPicture.asset(
            AppAssetManager.favourite,
            width: 22.r,
            height: 22.r,
            colorFilter:
                ColorFilter.mode(themeData.canvasColor, BlendMode.srcIn),
          ),
        ),
      )
    ],
  );
}

Widget _buildDescription(ThemeData themeData) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Text(
            '${StringManager.description}:',
            style: themeData.textTheme.bodyLarge!
                .copyWith(fontSize: FontSizeManager.f12),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgPicture.asset(AppAssetManager.star,
                    width: 18.r, height: 18.r),
                SizedBox(width: 7.w),
                Text(
                  '3.9 (200 ratings)',
                  style: themeData.textTheme.bodyMedium!,
                )
              ],
            ),
          ),
        ],
      ),
      SizedBox(height: 6.h),
      Text(
        'Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday',
        style: themeData.textTheme.bodyMedium,
      ),
    ],
  );
}
