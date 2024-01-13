part of '../pages/product_details_page.dart';

Widget _buildImage(ThemeData themeData, ProductDetailState state) {
  return Hero(
    tag: state.productDetails!.image,
    child: Container(
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

Widget _buildSpecification(ThemeData themeData) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '${StringManager.specifications}:',
        style: themeData.textTheme.bodyLarge!
            .copyWith(fontSize: FontSizeManager.f12),
      ),
      SizedBox(height: 6.h),
      _specificationText(StringManager.specification1, themeData),
      _specificationText(StringManager.specification2, themeData),
      _specificationText(StringManager.specification3, themeData),
      _specificationText(StringManager.specification4, themeData),
      _specificationText(StringManager.specification5, themeData),
      _specificationText(StringManager.specification6, themeData),
      _specificationText(StringManager.specification7, themeData),
    ],
  );
}

_specificationText(String text, ThemeData themeData) {
  return Text('• $text', style: themeData.textTheme.bodyMedium);
}

Widget _buildTitleAndCategory(ThemeData themeData, ProductDetailState state) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              state.productDetails!.title,
              style: themeData.textTheme.bodyMedium!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            Text(
              state.productDetails!.category.toUpperCase(),
              style: themeData.textTheme.bodyMedium!
                  .copyWith(color: themeData.disabledColor),
            ),
            SizedBox(height: 4.h),
            Text(
              '\$ ${state.productDetails!.price}',
              style: themeData.textTheme.bodyLarge!.copyWith(
                  color: themeData.canvasColor, fontSize: FontSizeManager.f18),
            )
          ],
        ),
      ),
      SizedBox(width: 10.w),
      BlocBuilder<ProductListBloc, ProductListState>(
          builder: (context, pState) {
        return GestureDetector(
          onTap: () {
            context
                .read<ProductListBloc>()
                .add(ProductListSetFavouritesEvent(state.productDetails!.id));
          },
          child: pState.favouriteIds.contains(state.productDetails!.id)
              ? Image.asset(
                  AppAssetManager.favouriteFill,
                  width: 22.r,
                  height: 22.r,
                )
              : SvgPicture.asset(
                  AppAssetManager.favourite,
                  width: 22.r,
                  height: 22.r,
                  colorFilter:
                      ColorFilter.mode(themeData.canvasColor, BlendMode.srcIn),
                ),
        );
      })
    ],
  );
}
