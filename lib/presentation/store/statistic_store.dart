import 'package:flutter_application_1/core/store/error/error_store.dart';
import 'package:flutter_application_1/core/store/form/form_store.dart';
import 'package:flutter_application_1/data/network/exceptions/network_exceptions.dart';
import 'package:flutter_application_1/domain/entities/Statistic.dart';
import 'package:flutter_application_1/domain/entities/User.dart';
import 'package:flutter_application_1/domain/usecases/expense/statistic_usecase.dart';
import 'package:mobx/mobx.dart';
part 'statistic_store.g.dart';

class StatisticStore = _StatisticStore with _$StatisticStore;

abstract class _StatisticStore with Store {
  // constructor:---------------------------------------------------------------
  _StatisticStore(
    this._statisticUseCase,
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
  static ObservableFuture<Statistic?> emptyStatisticResponse =
      ObservableFuture.value(null);

  // store variables:-----------------------------------------------------------
  @observable
  ObservableFuture<Statistic?> statisticFuture = emptyStatisticResponse;

  @observable
  bool success = false;
  // stores:--------------------------------------------------------------------
  // for handling form errors
  final FormErrorStore formErrorStore;

  // store for handling error messages
  final ErrorStore errorStore;
  // use cases:-----------------------------------------------------------------
  final StatisticUsecase _statisticUseCase;
  // actions:-------------------------------------------------------------------
  @action
  Future statistic(DateTime createDate) async {
    print("Đang gọi API với ngày: $createDate");
    final StatisticParams statisticParams = StatisticParams(
      createdDate: createDate,
    );
    try {
      final future = _statisticUseCase.call(params: statisticParams);
      statisticFuture = ObservableFuture(future);
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
