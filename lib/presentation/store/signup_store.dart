import 'package:flutter_application_1/core/store/error/error_store.dart';
import 'package:flutter_application_1/core/store/form/form_store.dart';
import 'package:flutter_application_1/data/network/exceptions/network_exceptions.dart';
import 'package:flutter_application_1/domain/entities/user/User.dart';
import 'package:flutter_application_1/domain/usecases/user/signup_usecase.dart';
import 'package:mobx/mobx.dart';
part 'signup_store.g.dart';
class SignupStore =  _SignupStore with _$SignupStore;

abstract class _SignupStore with Store {
  // constructor:---------------------------------------------------------------
  _SignupStore(
    this._registerUseCase,
    this.errorStore,
    this.formErrorStore, 
    
    
    ) {
      _setupDisposers();
    }
   
  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  void _setupDisposers() {
    _disposers = [reaction((_) => success, (_) => success = false, delay: 2000)];
  }
    // empty responses:-----------------------------------------------------------
  static ObservableFuture<User?> emptyRegisterResponse = ObservableFuture.value(
    null,
  );

  // store variables:-----------------------------------------------------------
  @observable
  ObservableFuture<User?> registerFuture = emptyRegisterResponse;


  @observable
  bool success = false;
  // stores:--------------------------------------------------------------------
  // for handling form errors
  final FormErrorStore formErrorStore;

  // store for handling error messages
  final ErrorStore errorStore;
    // use cases:-----------------------------------------------------------------
  final RegisterUseCase _registerUseCase;
 // actions:-------------------------------------------------------------------
  @action
  Future register(String email, String password, String lastname, String firstname,String phonenumber , DateTime dateOfBirth ) async {
    final RegisterParams registerParams = RegisterParams(
      email: email,
      password: password,
      firstName: firstname,
      lastName: lastname, 
      phoneNumber: phonenumber,
      dateOfBirth: dateOfBirth,


    );
    final future = _registerUseCase.call(params: registerParams);
    registerFuture = ObservableFuture(future);
    print("Register future: $future.");
    await future
        .then((value) async {
          if (value != null) {
            success = true;
          }
        })
        .catchError((e) {
          success = false;
          if (e is NetworkException) {
            errorStore.errorMessage = e.message ?? 'Đăng ký thất bại!';
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
