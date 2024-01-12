part of '../pages/product_details_page.dart';

Widget _buildImage(ThemeData themeData, ProductDetailState state) {
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
          imageUrl: state.productDetails!.image,
          placeholder: (context, url) {
            return Container(
              color: ColorManager.tintOrange.withOpacity(0.5),
              alignment: Alignment.center,
              child: SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(
                  color: themeData.canvasColor,
                  strokeWidth: 2.5.r,
                ),
              ),
            );
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

Widget _buildDescription(ThemeData themeData, ProductDetailState state) {
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
                _buildRating(state.productDetails!.rating.rate),
                SizedBox(width: 7.w),
                Text(
                  '${state.productDetails!.rating.rate} (${state.productDetails!.rating.count} ratings)',
                  style: themeData.textTheme.bodyMedium!,
                )
              ],
            ),
          ),
        ],
      ),
      SizedBox(height: 6.h),
      Text(
        state.productDetails!.description,
        style: themeData.textTheme.bodyMedium,
      ),
    ],
  );
}

Widget _buildRating(double rating) {
  return rw.RatingBar(
    itemSize: 15.r,
    initialRating: rating,
    allowHalfRating: true,
    itemCount: 5,
    ratingWidget: rw.RatingWidget(
      full: SvgPicture.asset(AppAssetManager.starFill),
      half: SvgPicture.asset(AppAssetManager.starHalf),
      empty: SvgPicture.asset(AppAssetManager.starEmpty),
    ),
    ignoreGestures: true,
    onRatingUpdate: (rating) {},
  );
}
