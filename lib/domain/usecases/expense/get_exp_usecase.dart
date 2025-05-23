import 'package:decimal/decimal.dart';
import 'package:flutter_application_1/domain/entities/Expense.dart';
import 'package:flutter_application_1/domain/repositories/exp_repository.dart';
import '../../../core/domain/usecase/use_case.dart';
import 'package:json_annotation/json_annotation.dart';
part 'get_exp_usecase.g.dart';

@JsonSerializable()
class GetExpParams {
  final Decimal? amount;
  final DateTime? createdDate;
  final String? description;
  final String? type;
  final String? keyword;

  GetExpParams({
    this.amount,
    this.createdDate,
    this.description,
    this.type,
    this.keyword,
  });
  factory GetExpParams.fromJson(Map<String, dynamic> json) =>
      _$GetExpParamsFromJson(json);
  Map<String, dynamic> toJson() => _$GetExpParamsToJson(this);
}

class GetExpUsecase implements UseCase<List<Expense?>, GetExpParams> {
  final ExpRepository _expenseRepository;
  GetExpUsecase(this._expenseRepository);
  @override
  Future<List<Expense?>> call({required GetExpParams params}) async {
    return _expenseRepository.getExp(params);
  }
}
