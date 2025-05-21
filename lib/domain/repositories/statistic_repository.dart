import 'package:flutter_application_1/domain/entities/Statistic.dart';
import 'package:flutter_application_1/domain/usecases/expense/statistic_usecase.dart';

abstract class StatisticRepository {
  Future<Statistic> statistic(StatisticParams params);
  
}