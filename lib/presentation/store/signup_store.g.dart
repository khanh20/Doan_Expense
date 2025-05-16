// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SignupStore on _SignupStore, Store {
  late final _$registerFutureAtom =
      Atom(name: '_SignupStore.registerFuture', context: context);

  @override
  ObservableFuture<User?> get registerFuture {
    _$registerFutureAtom.reportRead();
    return super.registerFuture;
  }

  @override
  set registerFuture(ObservableFuture<User?> value) {
    _$registerFutureAtom.reportWrite(value, super.registerFuture, () {
      super.registerFuture = value;
    });
  }

  late final _$successAtom =
      Atom(name: '_SignupStore.success', context: context);

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

  late final _$registerAsyncAction =
      AsyncAction('_SignupStore.register', context: context);

  @override
  Future<dynamic> register(String email, String password, String lastname,
      String firstname, String phonenumber, DateTime dateOfBirth) {
    return _$registerAsyncAction.run(() => super.register(
        email, password, lastname, firstname, phonenumber, dateOfBirth));
  }

  @override
  String toString() {
    return '''
registerFuture: ${registerFuture},
success: ${success}
    ''';
  }
}
