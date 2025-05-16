import 'package:decimal/decimal.dart';
import 'package:flutter_application_1/domain/entities/expense/Expense.dart';
import 'package:flutter_application_1/domain/repositories/exp_respository.dart';
import '../../../core/domain/usecase/use_case.dart';
import 'package:json_annotation/json_annotation.dart';
part 'create_exp_usecase.g.dart';
@JsonSerializable()
class CreateExpParams {
  final Decimal amount;
  final DateTime createdDate;
  final String description;
  final String type;
  final int categoryId;

  CreateExpParams({
    required this.categoryId,
    required this.amount,
    required this.createdDate,
    required this.description,
    required this.type,
  });
  factory CreateExpParams.fromJson(Map<String, dynamic> json) =>
      _$CreateExpParamsFromJson(json);
  Map<String, dynamic> toJson() => _$CreateExpParamsToJson(this);
  
}
class CreateExpUsecase implements UseCase<Expense?, CreateExpParams> {
  final ExpRepository _expenseRepository;
  CreateExpUsecase(this._expenseRepository);
  @override
  Future<Expense?> call({required CreateExpParams params}) async {
    return _expenseRepository.createExp(params);
  }
}