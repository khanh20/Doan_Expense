import 'package:decimal/decimal.dart';
import 'package:flutter_application_1/data/network/exceptions/network_exceptions.dart';
import 'package:flutter_application_1/domain/entities/Expense.dart';
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
    _disposers = [
   
    ];
  }
  // empty responses:-----------------------------------------------------------
  static ObservableFuture<Expense?> emptyCreateExpResponse = ObservableFuture.value(
    null,
  
  );
    static ObservableFuture<Expense?> emptyResponse = ObservableFuture.value(
    null,
  );
  // store variables:-----------------------------------------------------------
  @observable
  ObservableFuture<Expense?> createExpFuture = emptyCreateExpResponse;
  @computed
  bool get isLoading => createExpFuture.status == FutureStatus.pending;
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
    print('Future của usecase: $future');
    createExpFuture = ObservableFuture(future);

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
 void resetSuccess() {
   print('[resetSuccess] called');
  success = false;
}

}