import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/store/error/error_store.dart';
import 'package:flutter_application_1/di/service_locator.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 final _errorStore = getIt<ErrorStore>();
 final _createExpStore = getIt<CreateExpStore>();
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
      
      
    ];
  }




  
    
  
}

