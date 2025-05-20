import 'dart:async';
import 'package:flutter_application_1/data/network/api/api_get_category.dart';
import 'package:flutter_application_1/data/network/exceptions/network_exceptions.dart';
import 'package:flutter_application_1/data/sharedpref/shared_preference_helper.dart';
import 'package:flutter_application_1/domain/repositories/category_repository.dart';
import 'package:flutter_application_1/domain/entities/Category.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;
  final ApiGetCategory _apiGetCategory;

  // constructor
  CategoryRepositoryImpl(this._sharedPrefsHelper, this._apiGetCategory);

  // Create:---------------------------------------------------------------------
  @override
  Future<List<Category?>> getCategories() async {
    try {
      final response = await _apiGetCategory.getCategories();

      if (response['items'] is! List) {
        throw NetworkException(message: 'Dữ liệu không hợp lệ.');
      }

      final categories =
          (response['items'] as List).map((item) {
            if (item == null) return null;
            return Category(
              name: item['name'] ?? '',
              type: item['type'] ?? '',
              categoryId: item['categoryId'] ?? 0,
            );
          }).toList();

      return categories;
    } on NetworkException catch (e) {
      rethrow;
    } catch (e) {
      print('Unexpected error: $e');
      throw NetworkException(message: 'Đã xảy ra lỗi không xác định.');
    }
  }
}
