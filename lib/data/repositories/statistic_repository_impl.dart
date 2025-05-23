import 'dart:async';
import 'package:decimal/decimal.dart';
import 'package:flutter_application_1/data/network/api/api_statistics.dart';
import 'package:flutter_application_1/data/network/exceptions/network_exceptions.dart';
import 'package:flutter_application_1/data/sharedpref/shared_preference_helper.dart';
import 'package:flutter_application_1/domain/entities/Statistic.dart';
import 'package:flutter_application_1/domain/repositories/statistic_repository.dart';
import 'package:flutter_application_1/domain/usecases/expense/statistic_usecase.dart';

class StatisticRepositoryImpl extends StatisticRepository {
  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;
  final ApiStatistics _apiStatistics;

  // constructor
  StatisticRepositoryImpl(this._sharedPrefsHelper, this._apiStatistics);

  // Create:---------------------------------------------------------------------
  @override
  Future<Statistic> statistic(StatisticParams params) async {
    try {
      final responseData = await _apiStatistics.statistics(params.createdDate);
      print('API response: $responseData');
      final statistic = Statistic(
        dayIncome: Decimal.parse(responseData['dayIncome'].toString()),
        dayExpense: Decimal.parse(responseData['dayExpense'].toString()),
        dayRemaining: Decimal.parse(responseData['dayRemaining'].toString()),
        monthIncome: Decimal.parse(responseData['monthIncome'].toString()),
        monthExpense: Decimal.parse(responseData['monthExpense'].toString()),
        monthRemaining: Decimal.parse(
          responseData['monthRemaining'].toString(),
        ),
        yearIncome: Decimal.parse(responseData['yearIncome'].toString()),
        yearExpense: Decimal.parse(responseData['yearExpense'].toString()),
        yearRemaining: Decimal.parse(responseData['yearRemaining'].toString()),
      );

      return statistic;
    } on NetworkException catch (e) {
      rethrow;
    } catch (e) {
      print('Unexpected error: $e');
      throw NetworkException(message: 'Đã xảy ra lỗi không xác định.');
    }
  }
}
