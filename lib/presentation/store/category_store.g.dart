// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CategoryStore on _CategoryStore, Store {
  Computed<List<Category>>? _$filteredCategoriesComputed;

  @override
  List<Category> get filteredCategories => (_$filteredCategoriesComputed ??=
          Computed<List<Category>>(() => super.filteredCategories,
              name: '_CategoryStore.filteredCategories'))
      .value;

  late final _$getCategoryFutureAtom =
      Atom(name: '_CategoryStore.getCategoryFuture', context: context);

  @override
  ObservableFuture<List<Category?>> get getCategoryFuture {
    _$getCategoryFutureAtom.reportRead();
    return super.getCategoryFuture;
  }

  @override
  set getCategoryFuture(ObservableFuture<List<Category?>> value) {
    _$getCategoryFutureAtom.reportWrite(value, super.getCategoryFuture, () {
      super.getCategoryFuture = value;
    });
  }

  late final _$categoriesAtom =
      Atom(name: '_CategoryStore.categories', context: context);

  @override
  List<Category> get categories {
    _$categoriesAtom.reportRead();
    return super.categories;
  }

  @override
  set categories(List<Category> value) {
    _$categoriesAtom.reportWrite(value, super.categories, () {
      super.categories = value;
    });
  }

  late final _$successAtom =
      Atom(name: '_CategoryStore.success', context: context);

  @override
  bool get success {
    _$successAtom.reportRead();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }

  late final _$selectedTypeAtom =
      Atom(name: '_CategoryStore.selectedType', context: context);

  @override
  String get selectedType {
    _$selectedTypeAtom.reportRead();
    return super.selectedType;
  }

  @override
  set selectedType(String value) {
    _$selectedTypeAtom.reportWrite(value, super.selectedType, () {
      super.selectedType = value;
    });
  }

  late final _$getCategoryAsyncAction =
      AsyncAction('_CategoryStore.getCategory', context: context);

  @override
  Future<void> getCategory() {
    return _$getCategoryAsyncAction.run(() => super.getCategory());
  }

  late final _$_CategoryStoreActionController =
      ActionController(name: '_CategoryStore', context: context);

  @override
  void setSelectedType(String type) {
    final _$actionInfo = _$_CategoryStoreActionController.startAction(
        name: '_CategoryStore.setSelectedType');
    try {
      return super.setSelectedType(type);
    } finally {
      _$_CategoryStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
getCategoryFuture: ${getCategoryFuture},
categories: ${categories},
success: ${success},
selectedType: ${selectedType},
filteredCategories: ${filteredCategories}
    ''';
  }
}
