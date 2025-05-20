import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/assets.dart';
import 'package:flutter_application_1/core/store/form/form_store.dart';
import 'package:flutter_application_1/presentation/widgets/app_icon_widget.dart';
import 'package:flutter_application_1/presentation/widgets/empty_app_bar_widget.dart';
import 'package:flutter_application_1/presentation/widgets/progress_indicator_widget.dart';
import 'package:flutter_application_1/presentation/widgets/rounded_button_widget.dart';
import 'package:flutter_application_1/presentation/widgets/textfield_widget.dart';
import 'package:flutter_application_1/data/sharedpref/constants/preferences.dart';
import 'package:flutter_application_1/presentation/store/login_store.dart';
import 'package:flutter_application_1/utils/device/device_utils.dart';
import 'package:flutter_application_1/utils/routes/routes.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:another_flushbar/flushbar_helper.dart';
import '../../di/service_locator.dart';

// ignore: use_key_in_widget_constructors
class LoginScreen extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //text controllers:-----------------------------------------------------------
  // ignore: prefer_final_fields
  TextEditingController _userEmailController = TextEditingController();
  // ignore: prefer_final_fields
  TextEditingController _passwordController = TextEditingController();

  //stores:---------------------------------------------------------------------

  final FormStore _formStore = getIt<FormStore>();
  final UserStore _userStore = getIt<UserStore>();
  
  //focus node:-----------------------------------------------------------------
  late FocusNode _passwordFocusNode;

  @override
  void initState() {
    super.initState();
    _passwordFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: EmptyAppBar(),
      backgroundColor: Colors.white, 
      body: _buildBody(),
    );
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    
    return Stack(
      children: <Widget>[
        MediaQuery.of(context).orientation == Orientation.landscape
            ? Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: _buildLeftSide(),
                  ),
                  Expanded(
                    flex: 1,
                    child: _buildRightSide(),
                  ),
                ],
              )
            : Center(child: _buildRightSide()),
        Observer(
          builder: (context) {
            return _userStore.success
                ? navigate(context)
                : _showErrorMessage(_userStore.errorStore.errorMessage);
          },
        ),
        Observer(
          builder: (context) {
            return Visibility(
              visible: _userStore.isLoading,
              child: CustomProgressIndicatorWidget(),
            );
          },
        )
      ],
    );
  }

  Widget _buildLeftSide() {
    return SizedBox.expand(
      child: Image.asset(
        Assets.loginBackground,
        fit: BoxFit.cover,
      ),
    );
  }

 Widget _buildRightSide() {
  return SingleChildScrollView(
    child: Padding(
      padding: const 
      EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          AppIconWidget(image: 'assets/images/login.png'),
          SizedBox(height: 24.0),
          _buildUserIdField(),
          _buildPasswordField(),
          SizedBox(height: 24.0), 
          _buildSignInButton(),
          SizedBox(height: 16.0),
          _textChangeSignup(),
        ],
      ),
    ),
  );
}


  Widget _buildUserIdField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: 'Nhập email ở đây',
          inputType: TextInputType.emailAddress,
          icon: Icons.person,
          // iconColor: _themeStore.darkMode ? Colors.white70 : Colors.black54,
          textController: _userEmailController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {
            _formStore.setUserId(_userEmailController.text);
          },
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(_passwordFocusNode);
          },
          errorText: _formStore.formErrorStore.userEmail,
        );
      },
    );
  }

  Widget _buildPasswordField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: 'Nhập password ở đây',
          isObscure: true,
          padding: EdgeInsets.only(top: 16.0),
          icon: Icons.lock,
          // iconColor: _themeStore.darkMode ? Colors.white70 : Colors.black54,
          textController: _passwordController,
          focusNode: _passwordFocusNode,
          errorText: _formStore.formErrorStore.password,
          onChanged: (value) {
            _formStore.setPassword(_passwordController.text);
          },
          
        );
        
      },
    );
    
  }  

Widget _buildSignInButton() {
  return Align(
    alignment: Alignment.center,
    child: SizedBox(
      width: 400,
      height: 50, 
      child: RoundedButtonWidget(
        buttonText: 'Đăng nhập',
        buttonColor: Colors.orangeAccent,
        textColor: Colors.white,
        onPressed: () async {
          if (_formStore.canLogin) {
            DeviceUtils.hideKeyboard(context);
            _userStore.login(_userEmailController.text, _passwordController.text);
          } else {
            _showErrorMessage('Vui lòng nhập đầy đủ thông tin!');
          }
        },
      ),
    ),
  );
}

Widget _textChangeSignup() {
  return Center(
    child: RichText(
      text: TextSpan(
        text: 'Bạn chưa có tài khoản? ',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black87),
        children: [
          TextSpan(
            text: 'Đăng ký tại đây',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.orangeAccent,
                  fontWeight: FontWeight.bold,
                ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pushNamed(context, Routes.signup);
              },
          ),
        ],
      ),
    ),
  );
}


Widget navigate(BuildContext context) {
  SharedPreferences.getInstance().then((prefs) {
    prefs.setBool(Preferences.is_logged_in, true);
  });

  Future.delayed(Duration(milliseconds: 0), () {
    // Thoong bao success
    FlushbarHelper.createSuccess(
      message: "Đăng nhập thành công!",
      duration: Duration(seconds: 1),
    ).show(context);

    // Điều hướng đến Home sau 1 giây
    Future.delayed(Duration(seconds: 1), () {
      Navigator.of(context).pushNamedAndRemoveUntil(
        Routes.mainBottom, (Route<dynamic> route) => false);
    });
  });

  return Container();
}


  // General Methods:-----------------------------------------------------------
  _showErrorMessage(String message) {
    if (message.isNotEmpty) {
      Future.delayed(Duration(milliseconds: 0), () {
        if (message.isNotEmpty) {
          FlushbarHelper.createError(
            message: message,
            duration: Duration(seconds: 3),
          ).show(context);
        }
      });
    }

    return SizedBox.shrink();
  }

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    _userEmailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }
}

  // Widget _buildForgotPasswordButton() {
  //   return Align(
  //     alignment: FractionalOffset.centerRight,
  //     child: MaterialButton(
  //       padding: EdgeInsets.all(0.0),
  //       child: Text(
  //         AppLocalizations.of(context).translate('login_btn_forgot_password'),
  //         style: Theme.of(context)
  //             .textTheme
  //             .bodySmall
  //             ?.copyWith(color: Colors.orangeAccent),
  //       ),
  //       onPressed: () {},
  //     ),
  //   );
  // }