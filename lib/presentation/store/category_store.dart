import 'package:flutter_application_1/data/network/exceptions/network_exceptions.dart';
import 'package:flutter_application_1/domain/entities/Category.dart';
import 'package:flutter_application_1/domain/usecases/category/get_category_usecase.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_application_1/core/store/error/error_store.dart';

part "category_store.g.dart";

class CategoryStore = _CategoryStore with _$CategoryStore;

abstract class _CategoryStore with Store {
  _CategoryStore(this._getCategoryUsecase, this.errorStore) {
    _setupDisposers();
  }

  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  void _setupDisposers() {
    _disposers = [
      reaction<bool>((_) => success, (success) {
        if (success) {
          Future.delayed(Duration(seconds: 2), () {
            this.success = false;
          });
        }
      }),
    ];
  }
  // empty responses:-----------------------------------------------------------

  // store variables:-----------------------------------------------------------

  @observable
  ObservableFuture<List<Category?>> getCategoryFuture = ObservableFuture.value(
    <Category?>[],
  );
  @observable
  List<Category> categories = [];
  @observable
  bool success = false;
  @observable
  String selectedType = 'income';
  @computed
  List<Category> get filteredCategories {
    return categories.where((cat) => cat.type == selectedType).toList();
  }

  @action
  void setSelectedType(String type) {
    selectedType = type;
  }

  // stores:--------------------------------------------------------------------
  final GetCategoryUsecase _getCategoryUsecase;
  final ErrorStore errorStore;
  @action
  Future<void> getCategory() async {
    // final getAllCategoriesParams = GetAllCategoriesParams();
    final future = _getCategoryUsecase.call(params: NoParams());
    getCategoryFuture = ObservableFuture(future);

    await future
        .then((value) async {
          success = true;
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
