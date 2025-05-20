// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on _HomeStore, Store {
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading => (_$isLoadingComputed ??=
          Computed<bool>(() => super.isLoading, name: '_HomeStore.isLoading'))
      .value;

  late final _$createExpFutureAtom =
      Atom(name: '_HomeStore.createExpFuture', context: context);

  @override
  ObservableFuture<Expense?> get createExpFuture {
    _$createExpFutureAtom.reportRead();
    return super.createExpFuture;
  }

  @override
  set createExpFuture(ObservableFuture<Expense?> value) {
    _$createExpFutureAtom.reportWrite(value, super.createExpFuture, () {
      super.createExpFuture = value;
    });
  }

  late final _$successAtom = Atom(name: '_HomeStore.success', context: context);

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

  late final _$createExpAsyncAction =
      AsyncAction('_HomeStore.createExp', context: context);

  @override
  Future<dynamic> createExp(Decimal amount, String description,
      DateTime createdDate, String type, int categoryId) {
    return _$createExpAsyncAction.run(() =>
        super.createExp(amount, description, createdDate, type, categoryId));
  }

  @override
  String toString() {
    return '''
createExpFuture: ${createExpFuture},
success: ${success},
isLoading: ${isLoading}
    ''';
  }
}
