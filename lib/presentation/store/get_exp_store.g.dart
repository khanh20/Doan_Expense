// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_exp_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$GetExpStore on _GetExpStore, Store {
  late final _$getExpFutureAtom =
      Atom(name: '_GetExpStore.getExpFuture', context: context);

  @override
  ObservableFuture<List<Expense?>> get getExpFuture {
    _$getExpFutureAtom.reportRead();
    return super.getExpFuture;
  }

  @override
  set getExpFuture(ObservableFuture<List<Expense?>> value) {
    _$getExpFutureAtom.reportWrite(value, super.getExpFuture, () {
      super.getExpFuture = value;
    });
  }

  late final _$successAtom =
      Atom(name: '_GetExpStore.success', context: context);

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

  late final _$getExpAsyncAction =
      AsyncAction('_GetExpStore.getExp', context: context);

  @override
  Future<dynamic> getExp(String keyword) {
    return _$getExpAsyncAction.run(() => super.getExp(keyword));
  }

  @override
  String toString() {
    return '''
getExpFuture: ${getExpFuture},
success: ${success}
    ''';
  }
}
