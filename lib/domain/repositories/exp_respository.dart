import 'package:flutter_application_1/domain/entities/expense/Expense.dart';
import 'package:flutter_application_1/domain/usecases/expense/create_exp_usecase.dart';

abstract class ExpRepository {
  Future<Expense?> createExp(CreateExpParams params);
  
}