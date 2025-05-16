import 'package:mobx/mobx.dart';

part 'main_store.g.dart'; // Sẽ được tạo tự động

class MainBottomStore = _MainBottomStore with _$MainBottomStore;

abstract class _MainBottomStore with Store {
  @observable
  int selectedTabIndex = 0;

  @action
  void setTabIndex(int index) {
    selectedTabIndex = index;
  }
}
