import 'package:product_app/core/values/asset_manager.dart';
import 'package:product_app/core/values/string_manager.dart';
import 'package:product_app/src/home/data/models/comment_model.dart';

import '../models/category_model.dart';

class ProductLocalDateSource {
  static List<CommentModel> comments = [
    CommentModel(
      comment: 'I really love the product. It feels so comfortable',
      commenter: 'John',
      date: DateTime.now(),
    ),
    CommentModel(
      comment: 'Good product. I would recommend it anytime',
      commenter: 'Peter',
      date: DateTime.now(),
    ),
    CommentModel(
      comment: 'Product is nice but after first washing, it lost its coloring',
      commenter: 'Zainab',
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    CommentModel(
      comment: 'Product is nice, great quality',
      commenter: 'Amanda',
      date: DateTime.now().subtract(const Duration(days: 7)),
    ),
    CommentModel(
      comment: 'Took too long to arrive but product was worth the wait',
      commenter: 'Stephan',
      date: DateTime.now().subtract(const Duration(days: 20)),
    ),
    CommentModel(
      comment: 'Product is good but it is a little too big for me',
      commenter: 'Brenda',
      date: DateTime.now().subtract(const Duration(seconds: 25)),
    ),
    CommentModel(
      comment: 'I\'ve been rocking this product for almost 2 months now',
      commenter: 'Richard',
      date: DateTime.now().subtract(const Duration(days: 45)),
    ),
    CommentModel(
      comment: 'Great product',
      commenter: 'Zod',
      date: DateTime.now().subtract(const Duration(seconds: 46)),
    ),
  ];

  static const List<CategoryModel> categories = [
    CategoryModel(
        imagePath: AppAssetManager.electronics,
        categoryName: StringManager.electronics),
    CategoryModel(
        imagePath: AppAssetManager.jewelry,
        categoryName: StringManager.jewelry),
    CategoryModel(
        imagePath: AppAssetManager.mensClothing,
        categoryName: StringManager.mensClothing),
    CategoryModel(
        imagePath: AppAssetManager.womensClothing,
        categoryName: StringManager.womensClothing),
  ];
}
