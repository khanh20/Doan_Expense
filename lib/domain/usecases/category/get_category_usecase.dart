import 'package:flutter_application_1/domain/repositories/category_repository.dart';
import '../../../core/domain/usecase/use_case.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_application_1/domain/entities/Category.dart';

part 'get_category_usecase.g.dart';
@JsonSerializable()
class GetAllCategoriesParams {
  GetAllCategoriesParams();
  factory GetAllCategoriesParams.fromJson(Map<String, dynamic> json) =>
      _$GetAllCategoriesParamsFromJson(json);
  Map<String, dynamic> toJson() => _$GetAllCategoriesParamsToJson(this);
  
}
class GetCategoryUsecase implements UseCase<List<Category?>, NoParams> {
  final CategoryRepository _categoryRepository;
  GetCategoryUsecase(this._categoryRepository);
  @override
   Future<List<Category?>> call({required NoParams params}) async {
    return _categoryRepository.getCategories();
  }
}
class NoParams {}