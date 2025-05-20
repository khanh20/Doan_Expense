import 'dart:async';
import 'package:decimal/decimal.dart';
import 'package:flutter_application_1/data/network/api/api_create_exp.dart';
import 'package:flutter_application_1/data/network/exceptions/network_exceptions.dart';
import 'package:flutter_application_1/data/sharedpref/shared_preference_helper.dart';
import 'package:flutter_application_1/domain/entities/Expense.dart';
import 'package:flutter_application_1/domain/repositories/exp_repository.dart';

import 'package:flutter_application_1/domain/usecases/expense/create_exp_usecase.dart';

class ExpRepositoryImpl extends ExpRepository {
  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;
  final ApiCreateExp _apiCreateExp;

  // constructor
  ExpRepositoryImpl(this._sharedPrefsHelper, this._apiCreateExp);

  // Create:---------------------------------------------------------------------
  @override
  Future<Expense?> createExp(CreateExpParams params) async {
    try {
      final responseData = await _apiCreateExp.createExp(
        params.amount,
        params.description,
        params.createdDate,
        params.type,
        params.categoryId,
      );

      final expense = Expense(
        userId: responseData['userId'] ?? '',
        amount: Decimal.parse(responseData['amount'].toString()),
        createdDate: DateTime.parse(responseData['createdDate']),
        description: responseData['description'],
        type: responseData['type'],
        categoryId: responseData['categoryId'],
        expenseId: responseData['expenseId'],
      );

      return expense;
    } on NetworkException catch (e) {
      rethrow;
    } catch (e) {
      print('Unexpected error: $e');
      throw NetworkException(message: 'Đã xảy ra lỗi không xác định.');
    }
  }
}
