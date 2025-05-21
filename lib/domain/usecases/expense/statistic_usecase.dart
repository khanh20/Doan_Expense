import 'package:decimal/decimal.dart';
import 'package:flutter_application_1/domain/entities/Expense.dart';
import 'package:flutter_application_1/domain/entities/Statistic.dart';
import 'package:flutter_application_1/domain/repositories/exp_repository.dart';
import 'package:flutter_application_1/domain/repositories/statistic_repository.dart';
import '../../../core/domain/usecase/use_case.dart';
import 'package:json_annotation/json_annotation.dart';
part 'statistic_usecase.g.dart';
@JsonSerializable()
class StatisticParams {
  final DateTime createdDate;
  StatisticParams({
    required this.createdDate,
  });
  factory StatisticParams.fromJson(Map<String, dynamic> json) =>
      _$StatisticParamsFromJson(json);
  Map<String, dynamic> toJson() => _$StatisticParamsToJson(this);
  
}
class StatisticUsecase implements UseCase<Statistic, StatisticParams> {
  final StatisticRepository _statisticRepository;
  StatisticUsecase(this._statisticRepository);
  @override
  Future<Statistic> call({required StatisticParams params}) async {
    return _statisticRepository.statistic(params);
  }
}