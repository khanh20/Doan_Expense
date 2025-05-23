import 'package:flutter_application_1/core/store/error/error_store.dart';
import 'package:flutter_application_1/core/store/form/form_store.dart';
import 'package:flutter_application_1/data/network/exceptions/network_exceptions.dart';
import 'package:flutter_application_1/domain/entities/Expense.dart';
import 'package:flutter_application_1/domain/usecases/expense/get_exp_usecase.dart';
import 'package:mobx/mobx.dart';
part 'get_exp_store.g.dart';

class GetExpStore = _GetExpStore with _$GetExpStore;

abstract class _GetExpStore with Store {
  // constructor:---------------------------------------------------------------
  _GetExpStore(
    this._getExpUseCase,
    this.errorStore,
    this.formErrorStore,
  ) {
    _setupDisposers();
  }

  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  void _setupDisposers() {
    _disposers = [
      reaction((_) => success, (_) => success = false, delay: 2000),
    ];
  }

  // empty responses:-----------------------------------------------------------
  static ObservableFuture<List<Expense?>> emptyGetExpResponse =
      ObservableFuture.value([]);

  // store variables:-----------------------------------------------------------
  @observable
  ObservableFuture<List<Expense?>> getExpFuture = emptyGetExpResponse;

  @observable
  bool success = false;
  // stores:--------------------------------------------------------------------
  // for handling form errors
  final FormErrorStore formErrorStore;

  // store for handling error messages
  final ErrorStore errorStore;
  // use cases:-----------------------------------------------------------------
  final GetExpUsecase _getExpUseCase;
  // actions:-------------------------------------------------------------------
  @action
  Future getExp(String keyword) async {
    print("Đang gọi API với ngày: $keyword");
    final GetExpParams getExpParams = GetExpParams(
      keyword: keyword,
    );
    try {
      final future = _getExpUseCase.call(params: getExpParams);
      getExpFuture = ObservableFuture(future);
      print("Đã gửi request API, future: $future");
      print("Statistic future: $future.");
      final value = await future;
      
      success = true;
       print("API gọi thành công, dữ liệu: $value");  
    } catch (e) {
      success = false;
      if (e is NetworkException) {
        errorStore.errorMessage = e.message ?? 'Tạo thất bại!';
      } else {
        errorStore.errorMessage = 'Lỗi không xác định: ${e.toString()}';
      }
    }
  }

  // general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}
