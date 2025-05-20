import 'package:flutter_application_1/domain/entities/Category.dart';
abstract class CategoryRepository {
  Future<List<Category?>> getCategories();
  
}