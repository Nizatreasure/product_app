import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:product_app/core/routes/route_names.dart';
import 'package:product_app/core/values/asset_manager.dart';
import 'package:product_app/core/values/color_manager.dart';
import 'package:product_app/core/values/fontsize_manager.dart';
import 'package:product_app/src/home/data/models/product_model.dart';
import 'package:shimmer/shimmer.dart';

import '../blocs/product_list_bloc/product_list_bloc.dart';

class ProductItem extends StatelessWidget {
  final ProductModel? productModel;
  final bool showFavouriteButton;
  const ProductItem(
      {super.key, this.productModel, this.showFavouriteButton = false});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return GestureDetector(
      onTap: () {
        if (productModel == null) return;
        context.pushNamed(RouteNames.productDetails,
            pathParameters: {'id': productModel!.id.toString()});
      },
      child: Container(
        height: 100.h,
        margin: EdgeInsetsDirectional.only(bottom: 25.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: themeData.scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: ColorManager.black.withOpacity(0.1),
              blurRadius: 4,
              spreadRadius: 0,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Row(
          children: [
            _buildHero(
              productModel: productModel,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: SizedBox(
                  width: 100.h,
                  height: 100.h,
                  child: productModel == null
                      ? Container(
                          color: ColorManager.tintOrange.withOpacity(0.5))
                      : CachedNetworkImage(
                          imageUrl: productModel!.image,
                          fit: BoxFit.cover,
                          placeholder: (context, url) {
                            return Container(
                              color: ColorManager.tintOrange.withOpacity(0.5),
                              alignment: Alignment.center,
                              child: SizedBox(
                                height: 25,
                                width: 25,
                                child: CircularProgressIndicator(
                                  color: themeData.canvasColor,
                                  strokeWidth: 2.5.r,
                                ),
                              ),
                            );
                          },
                          errorWidget: (context, url, error) {
                            return Container(
                                color:
                                    ColorManager.tintOrange.withOpacity(0.5));
                          },
                        ),
                ),
              ),
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 12.h, 12.w, 1.h),
                child: productModel == null
                    ? _buildShimmer()
                    : _buildProductDisplay(themeData),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHero(
      {required ProductModel? productModel, required Widget child}) {
    return productModel == null
        ? child
        : Hero(tag: productModel.image, child: child);
  }

  Widget _buildProductDisplay(ThemeData themeData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          productModel!.category.toUpperCase(),
          style: themeData.textTheme.bodyMedium!.copyWith(
              fontSize: FontSizeManager.f10, color: themeData.disabledColor),
        ),
        SizedBox(height: 5.h),
        SizedBox(
          height: 30.h,
          child: Text(
            productModel!.title,
            style: themeData.textTheme.bodyMedium!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('\$ ${productModel!.price}',
                style: themeData.textTheme.bodyMedium!),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgPicture.asset(AppAssetManager.star,
                    width: 18.r, height: 15.r),
                SizedBox(width: 3.w),
                Text(
                  '${productModel?.rating.rate}',
                  style: themeData.textTheme.bodyMedium!,
                )
              ],
            ),
            if (showFavouriteButton)
              BlocBuilder<ProductListBloc, ProductListState>(
                  builder: (context, pState) {
                return GestureDetector(
                  onTap: () {
                    context
                        .read<ProductListBloc>()
                        .add(ProductListSetFavouritesEvent(productModel!.id));
                  },
                  child: pState.favouriteIds.contains(productModel!.id)
                      ? Image.asset(
                          AppAssetManager.favouriteFill,
                          width: 22.r,
                          height: 22.r,
                        )
                      : SvgPicture.asset(
                          AppAssetManager.favourite,
                          width: 22.r,
                          height: 22.r,
                          colorFilter: ColorFilter.mode(
                              themeData.canvasColor, BlendMode.srcIn),
                        ),
                );
              }),
          ],
        )
      ],
    );
  }

  _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade200,
      highlightColor: Colors.grey.shade300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FractionallySizedBox(
            widthFactor: 0.6,
            child: Container(
              color: Colors.grey,
              width: double.infinity,
              height: 10,
            ),
          ),
          SizedBox(height: 10.h),
          Container(
            color: Colors.grey,
            width: double.infinity,
            height: 15,
          ),
          SizedBox(height: 10.h),
          FractionallySizedBox(
            widthFactor: 0.4,
            child: Container(
              color: Colors.grey,
              width: double.infinity,
              height: 10,
            ),
          ),
        ],
      ),
    );
  }
}
