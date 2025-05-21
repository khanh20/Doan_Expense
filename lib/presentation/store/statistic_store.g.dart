// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistic_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$StatisticStore on _StatisticStore, Store {
  late final _$statisticFutureAtom =
      Atom(name: '_StatisticStore.statisticFuture', context: context);

  @override
  ObservableFuture<Statistic?> get statisticFuture {
    _$statisticFutureAtom.reportRead();
    return super.statisticFuture;
  }

  @override
  set statisticFuture(ObservableFuture<Statistic?> value) {
    _$statisticFutureAtom.reportWrite(value, super.statisticFuture, () {
      super.statisticFuture = value;
    });
  }

  late final _$successAtom =
      Atom(name: '_StatisticStore.success', context: context);

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

  late final _$statisticAsyncAction =
      AsyncAction('_StatisticStore.statistic', context: context);

  @override
  Future<dynamic> statistic(DateTime CreateDate) {
    return _$statisticAsyncAction.run(() => super.statistic(CreateDate));
  }

  @override
  String toString() {
    return '''
statisticFuture: ${statisticFuture},
success: ${success}
    ''';
  }
}
