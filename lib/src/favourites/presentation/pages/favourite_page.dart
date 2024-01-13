import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:product_app/core/common/form_submission/form_submission.dart';
import 'package:product_app/core/common/widgets/custom_app_bar.dart';
import 'package:product_app/core/common/widgets/custom_error_widget.dart';
import 'package:product_app/core/common/widgets/custom_loading_indicator.dart';
import 'package:product_app/core/values/asset_manager.dart';
import 'package:product_app/core/values/fontsize_manager.dart';
import 'package:product_app/core/values/string_manager.dart';
import 'package:product_app/src/home/data/models/product_model.dart';
import 'package:product_app/src/home/presentation/blocs/product_list_bloc/product_list_bloc.dart';
import 'package:product_app/src/home/presentation/widgets/product_item.dart';

part '../widgets/favourite_widgets.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: customAppBar(
        context,
        title: StringManager.favourites,
        centerTitle: true,
        showBackButton: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: BlocBuilder<ProductListBloc, ProductListState>(
          builder: (context, state) {
            return state.formSubmissionStatus is SubmissionFailure
                ? CustomErrorWidget(onTap: () {
                    context
                        .read<ProductListBloc>()
                        .add(ProductListGetProductsEvent());
                  })
                : state.formSubmissionStatus is SubmissionSuccess &&
                        state.favouriteIds.isNotEmpty
                    ? ListView.builder(
                        key: const PageStorageKey('favourites'),
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                        itemCount: state.favouriteIds.length,
                        itemBuilder: (context, index) {
                          Iterable<ProductModel>? faves = state.products?.where(
                              (element) =>
                                  element.id == state.favouriteIds[index]);
                          ProductModel? fave = faves != null && faves.isNotEmpty
                              ? faves.first
                              : null;
                          return ProductItem(
                            showFavouriteButton: true,
                            productModel: fave,
                          );
                        },
                      )
                    : state.formSubmissionStatus is SubmissionSuccess &&
                            state.favouriteIds.isEmpty
                        ? _buildNoFavourites(themeData)
                        : const CustomLoadingIndicator();
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
