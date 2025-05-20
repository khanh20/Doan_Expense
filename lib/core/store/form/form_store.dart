import 'package:decimal/decimal.dart';
import 'package:flutter_application_1/core/store/error/error_store.dart';
import 'package:mobx/mobx.dart';
import 'package:validators/validators.dart';

part 'form_store.g.dart';

// ignore: library_private_types_in_public_api
class FormStore = _FormStore with _$FormStore;

abstract class _FormStore with Store {
  // store for handling form errors
  final FormErrorStore formErrorStore;

  // store for handling error messages
  final ErrorStore errorStore;

  _FormStore(this.formErrorStore, this.errorStore) {
    _setupValidations();
  }

  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  void _setupValidations() {
    _disposers = [
      reaction((_) => userEmail, validateUserEmail),
      reaction((_) => password, validatePassword),
      reaction((_) => firstName, validateFirstName),
      reaction((_) => lastName, validateLastName),
      reaction((_) => phoneNumber, validatePhoneNumber),
    ];
  }

  // store variables:-----------------------------------------------------------
  @observable
  String userEmail = '';
  @observable
  String amount = '';

  @observable
  String password = '';

  @observable
  String firstName = '';

  @observable
  String lastName = '';

  @observable
  String phoneNumber = '';

  @observable
  DateTime? dateOfBirth;

  @observable
  bool success = false;

  @computed
  bool get canLogin =>
      !formErrorStore.hasErrorsInLogin &&
      userEmail.isNotEmpty &&
      password.isNotEmpty;

  @computed
  bool get canRegister =>
      !formErrorStore.hasErrorsInRegister &&
      userEmail.isNotEmpty &&
      password.isNotEmpty &&
      firstName.isNotEmpty &&
      lastName.isNotEmpty &&
      phoneNumber.isNotEmpty &&
      dateOfBirth != null;

  @computed
  bool get canForgetPassword =>
      !formErrorStore.hasErrorInForgotPassword && userEmail.isNotEmpty;

  // actions:-------------------------------------------------------------------
  @action
  void setUserId(String value) {
    userEmail = value;
  }

  @action
  void setAmount(String value) {
    amount = value;
  }

  @action
  void setPassword(String value) {
    password = value;
  }

  @action
  void setFirstName(String value) => firstName = value;

  @action
  void setLastName(String value) => lastName = value;

  @action
  void setPhoneNumber(String value) => phoneNumber = value;

  @action
  void setDateOfBirth(DateTime value) => dateOfBirth = value;

  // === Validators ===
@action
void validateAmount(String value) {
  if (value.isEmpty) {
    formErrorStore.amount = "Số tiền không được để trống";
  } else if (!isNumeric(value)) {
    formErrorStore.amount = "Số tiền không hợp lệ";
  } else if (Decimal.parse(value) <= Decimal.zero) {
    formErrorStore.amount = "Số tiền phải lớn hơn 0";
  } else {
    formErrorStore.amount = null;
  }
}


  void validateUserEmail(String value) {
    if (value.isEmpty) {
      formErrorStore.userEmail = "Email can't be empty";
    } else if (!isEmail(value)) {
      formErrorStore.userEmail = 'Please enter a valid email address';
    } else {
      formErrorStore.userEmail = null;
    }
  }

  @action
  void validatePassword(String value) {
    if (value.isEmpty) {
      formErrorStore.password = "Password can't be empty";
    } else if (value.length < 6) {
      formErrorStore.password = "Password must be at-least 6 characters long";
    } else {
      formErrorStore.password = null;
    }
  }

  @action
  void validateFirstName(String value) {
    if (value.isEmpty) {
      formErrorStore.firstName = "FirstName can't be empty";
    } else {
      formErrorStore.firstName = null;
    }
  }

  @action
  void validateLastName(String value) {
    if (value.isEmpty) {
      formErrorStore.lastName = "LastName can't be empty";
    } else {
      formErrorStore.lastName = null;
    }
  }

  @action
  void validatePhoneNumber(String value) {
    if (value.isEmpty) {
      formErrorStore.phoneNumber = "PhoneNumber can't be empty";
    } else if (!isNumeric(value) || value.length < 9) {
      formErrorStore.phoneNumber = "PhoneNumber is not valid";
    } else {
      formErrorStore.phoneNumber = null;
    }
  }

  // general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }

  void validateAll() {
    validatePassword(password);
    validateUserEmail(userEmail);
    validateFirstName(firstName);
    validateLastName(lastName);
    validatePhoneNumber(phoneNumber);
  }
}

class FormErrorStore = _FormErrorStore with _$FormErrorStore;

abstract class _FormErrorStore with Store {
  @observable
  String? userEmail;
  @observable
  String? amount;

  @observable
  String? password;

  @observable
  String? firstName;

  @observable
  String? lastName;

  @observable
  String? phoneNumber;
  @computed
  bool get hasErrorsInLogin => userEmail != null || password != null;

  @computed
  bool get hasErrorsInRegister =>
      userEmail != null ||
      password != null ||
      firstName != null ||
      lastName != null ||
      phoneNumber != null;

  @computed
  bool get hasErrorInForgotPassword => userEmail != null;
}
