import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/widgets/app_icon_widget.dart';
import 'package:flutter_application_1/presentation/widgets/empty_app_bar_widget.dart';
import 'package:flutter_application_1/presentation/widgets/progress_indicator_widget.dart';
import 'package:flutter_application_1/presentation/widgets/rounded_button_widget.dart';
import 'package:flutter_application_1/presentation/widgets/textfield_widget.dart';
import 'package:flutter_application_1/utils/device/device_utils.dart';
import 'package:flutter_application_1/utils/routes/routes.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../di/service_locator.dart';
import '../../core/store/form/form_store.dart';
import '../../core/store/error/error_store.dart';
import '../store/signup_store.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formStore = getIt<FormStore>();
  final _errorStore = getIt<ErrorStore>();
  final _signupStore = getIt<SignupStore>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _phoneController = TextEditingController();
  DateTime? _dob;

  late FocusNode _passwordFocusNode;

  @override
  void initState() {
    super.initState();
    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _firstnameController.dispose();
    _lastnameController.dispose();
    _phoneController.dispose();
    _passwordFocusNode.dispose();
    _signupStore.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EmptyAppBar(),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppIconWidget(image: 'assets/images/login.png'),
                SizedBox(height: 16),
                _buildTextField(
                  "Email",
                  _emailController,
                  TextInputType.emailAddress,
                  Icons.email,
                  (v) => _formStore.setUserId(v),
                  fieldName: "email",
                ),
                _buildTextField(
                  "Mật khẩu",
                  _passwordController,
                  TextInputType.text,
                  Icons.lock,
                  (v) => _formStore.setPassword(v),
                  obscureText: true,
                  fieldName: "password",
                ),
                _buildTextField(
                  "Họ",
                  _lastnameController,
                  TextInputType.name,
                  Icons.person,
                  (v) => _formStore.setLastName(v),
                  
                  fieldName: "lastName",
                ),

                _buildTextField(
                  "Tên",
                  _firstnameController,
                  TextInputType.name,
                  Icons.person_outline,
                  (v)=> _formStore.setFirstName(v),
                  
                  fieldName: "firstName",
                ),
                _buildTextField(
                  "SĐT",
                  _phoneController,
                  TextInputType.phone,
                  Icons.phone,
                  (v) => _formStore.setPhoneNumber(v),
                  
                  fieldName: "phone",
                ),

                _buildDatePicker(context),
                SizedBox(height: 16),
                _buildSignupButton(),
                SizedBox(height: 16),
                _textChangeLogin(),
              ],
            ),
          ),
          Observer(
            builder:
                (_) => Visibility(
                  visible:
                      _signupStore.registerFuture.status ==
                      FutureStatus.pending,
                  child: CustomProgressIndicatorWidget(),
                ),
          ),
          Observer(
            builder:
                (_) =>
                    _signupStore.success
                        ? _navigate(context)
                        : _showErrorMessage(_errorStore.errorMessage),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    String hint,
    TextEditingController controller,
    TextInputType type,
    IconData icon,
    Function(String) onChanged, {
    bool obscureText = false,
    required String fieldName,
  }) {
    String? getErrorText() {
      switch (fieldName) {
        case "email":
          return _formStore.formErrorStore.userEmail;
        case "password":
          return _formStore.formErrorStore.password;
        case "firstName":
          return _formStore.formErrorStore.firstName;
        case "lastName":
          return _formStore.formErrorStore.lastName;
        case "phone":
          return _formStore.formErrorStore.phoneNumber;
        default:
          return null;
      }
    }

    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: TextFieldWidget(
        hint: hint,
        inputType: type,
        textController: controller,
        icon: icon,
        isObscure: obscureText,
        errorText: getErrorText(),
        onChanged: (value) => onChanged(value),
      ),
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: GestureDetector(
        onTap: () async {
          final date = await showDatePicker(
            context: context,
            initialDate: DateTime(2000),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );
           if (date != null) {
    setState(() {
      _dob = date;
    });
    _formStore.setDateOfBirth(date); // ⚠️ Dòng này là bắt buộc
  }
        },
        child: AbsorbPointer(
          child: TextField(
            decoration: InputDecoration(
              labelText:
                  _dob == null
                      ? 'Chọn ngày sinh'
                      : '${_dob!.day}/${_dob!.month}/${_dob!.year}',
              prefixIcon: Icon(Icons.calendar_today),
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignupButton() {
    return RoundedButtonWidget(
      buttonText: 'Đăng ký',
      buttonColor: Colors.orangeAccent,
      textColor: Colors.white,
      height: 50,
      width: 400,
      onPressed: () {
        DeviceUtils.hideKeyboard(context);

        _formStore.validateAll();

        if (_formStore.canRegister && _dob != null) {
          _signupStore.register(
            _emailController.text,
            _passwordController.text,
            _lastnameController.text,
            _firstnameController.text,
            _phoneController.text,
            _dob!,
          );
        } else {
          _showErrorMessage('Vui lòng điền đầy đủ thông tin!');
        }
      },
    );
  }

  Widget _textChangeLogin() {
    return Center(
      child: RichText(
        text: TextSpan(
          text: 'Đã có tài khoản? ',
          style: TextStyle(color: Colors.black),
          children: [
            TextSpan(
              text: 'Đăng nhập',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              recognizer:
                  TapGestureRecognizer()
                    ..onTap = () => Navigator.pushNamed(context, Routes.login),
            ),
          ],
        ),
      ),
    );
  }

  Widget _navigate(BuildContext context) {
    print("Đăng ký thành công!");
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool("is_logged_in", true);
    });

    Future.delayed(Duration(milliseconds: 0), () {
      FlushbarHelper.createSuccess(
        message: "Đăng ký thành công!",
        duration: Duration(seconds: 2),
      ).show(context);

      // Điều hướng đến trang đăng nhập sau 2 giây
      Future.delayed(Duration(seconds: 2), () {
        Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.login,
          (Route<dynamic> route) => false,
        );
      });
    });

    return Container();
  }

  Widget _showErrorMessage(String message) {
    if (message.isNotEmpty) {
      Future.delayed(Duration(milliseconds: 0), () {
        FlushbarHelper.createError(
          message: message,
          duration: Duration(seconds: 3),
        ).show(context);
      });
    }
    return SizedBox.shrink();
  }
}
