import 'package:decimal/decimal.dart';
import 'package:flutter_application_1/data/network/exceptions/network_exceptions.dart';
import 'package:flutter_application_1/domain/entities/expense/Expense.dart';
import 'package:flutter_application_1/domain/usecases/expense/create_exp_usecase.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_application_1/core/store/error/error_store.dart';
part "home_store.g.dart";
class HomeStore = _HomeStore with _$HomeStore;
abstract class _HomeStore with Store {
  _HomeStore(
    this._createExpUsecase,
    this.errorStore,
  ){
      _setupDisposers();
    }

   // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  void _setupDisposers() {
    _disposers = [reaction((_) => success, (_) => success = false, delay: 2000)];
  }
  // empty responses:-----------------------------------------------------------
  static ObservableFuture<Expense?> emptyCreateExpResponse = ObservableFuture.value(
    null,
  );
  // store variables:-----------------------------------------------------------
  @observable
  ObservableFuture<Expense?> createExpFuture = emptyCreateExpResponse;

  @observable
  bool success = false;
  // stores:--------------------------------------------------------------------
  final CreateExpUsecase _createExpUsecase;
  final ErrorStore errorStore;
   @action
  Future createExp(Decimal amount,
    String description,
    DateTime createdDate,
    String type,
    int categoryId, ) async {
    final CreateExpParams createExpParams = CreateExpParams(
      amount: amount,
      description: description,
      createdDate: createdDate,
      type: type, 
      categoryId: categoryId,

    );
    final future = _createExpUsecase.call(params:createExpParams);
    createExpFuture = ObservableFuture(future);
    print("Create future: $future.");
    await future
        .then((value) async {
          if (value != null) {
            success = true;
          }
        })
        .catchError((e) {
          success = false;
          if (e is NetworkException) {
            errorStore.errorMessage = e.message ?? 'Tạo thất bại!';
          } else {
            errorStore.errorMessage = 'Lỗi không xác định: ${e.toString()}';
          }

        });
  }
    // general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
 
}