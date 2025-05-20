import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/sharedpref/constants/preferences.dart';
import 'package:flutter_application_1/utils/routes/routes.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatefulWidget {
  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  //stores:---------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
    );
  }

  // app bar methods:-----------------------------------------------------------
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      actions: _buildActions(context),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    return <Widget>[
      _buildLogoutButton(),
      
    ];
  }



  Widget _buildLogoutButton() {
    return IconButton(
      onPressed: () {
        SharedPreferences.getInstance().then((preference) {
          preference.setBool(Preferences.is_logged_in, false);
          Navigator.of(context).pushReplacementNamed(Routes.login);
        });
      },
      icon: Icon(
        Icons.power_settings_new,
      ),
    );
  }
  
    
  
}

