import 'dart:async';
import 'package:decimal/decimal.dart';
import 'package:flutter_application_1/data/network/api/api_create_exp.dart';
import 'package:flutter_application_1/data/network/api/api_get_exp.dart';
import 'package:flutter_application_1/data/network/exceptions/network_exceptions.dart';
import 'package:flutter_application_1/data/sharedpref/shared_preference_helper.dart';
import 'package:flutter_application_1/domain/entities/Expense.dart';
import 'package:flutter_application_1/domain/repositories/exp_repository.dart';

import 'package:flutter_application_1/domain/usecases/expense/create_exp_usecase.dart';
import 'package:flutter_application_1/domain/usecases/expense/get_exp_usecase.dart';

class ExpRepositoryImpl extends ExpRepository {
  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;
  final ApiCreateExp _apiCreateExp;
  final ApiGetExp _apiGetExp;

  // constructor
  ExpRepositoryImpl(this._sharedPrefsHelper, this._apiCreateExp, this._apiGetExp);

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
        userId: responseData['userId'] ?? 0,
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
   @override
  Future<List<Expense?>> getExp(GetExpParams params) async {
    try {
      print("API IMPL");
      final responseData = await _apiGetExp.getExp(
        keyword: params.keyword,      
      );
       if (responseData['items'] is! List) {
        throw NetworkException(message: 'Dữ liệu không hợp lệ.');
      }

      final expense = (responseData["items"]as List).map((item){
        if (item == null) return null;
        return Expense(
          userId: 0,
          description: item['description'],
          categoryId: item['categoryId'] ?? 0,
          expenseId: item['expenseId'] ?? 0,
          amount: Decimal.parse(item['amount'].toString()),
          createdDate: DateTime.parse(item['createdDate']),
          type: item['type'] ?? '',

        );
      }).toList();
      return expense;
    } on NetworkException catch (e) {
      rethrow;
    } catch (e) {
      print('Unexpected error: $e');
      throw NetworkException(message: 'Đã xảy ra lỗi không xác định.');
    }
  }

  

  
}
