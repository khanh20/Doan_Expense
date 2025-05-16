import 'package:flutter/material.dart';

class StatisticalScreen extends StatelessWidget {
  const StatisticalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Statistical'),
      ),
      body: Center(
        child: Text('Statistical Screen'),
      ),
    );
  }
}