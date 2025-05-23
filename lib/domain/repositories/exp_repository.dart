import 'package:flutter_application_1/domain/entities/Expense.dart';
import 'package:flutter_application_1/domain/usecases/expense/create_exp_usecase.dart';
import 'package:flutter_application_1/domain/usecases/expense/get_exp_usecase.dart';

abstract class ExpRepository {
  Future<Expense?> createExp(CreateExpParams params);
  Future<List<Expense?>> getExp(GetExpParams params);

  
}