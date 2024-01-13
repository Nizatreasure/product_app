import 'package:flutter/material.dart';
import 'package:product_app/core/values/asset_manager.dart';
import 'package:product_app/core/values/string_manager.dart';
import 'package:product_app/src/home/presentation/pages/home_page.dart';
import 'package:product_app/src/profile/presentation/pages/profile_page.dart';

import '../models/landing_model.dart';

class LandingLocalDataSource {
  static List<LandingPageModel> get pages => [
        LandingPageModel(
          assetName: AppAssetManager.home,
          widget: const HomePage(),
          displayText: StringManager.home,
        ),
        LandingPageModel(
          assetName: AppAssetManager.order,
          widget: Container(),
          displayText: StringManager.order,
        ),
        LandingPageModel(
          assetName: AppAssetManager.favourite,
          widget: Container(),
          displayText: StringManager.favourites,
        ),
        LandingPageModel(
          assetName: AppAssetManager.account,
          widget: const ProfilePage(),
          displayText: StringManager.account,
        ),
      ];
}
