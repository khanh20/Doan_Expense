import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/entities/User.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'home_screen.dart';
import 'calendar_screen.dart';
import 'statistical_screen.dart';
import 'setting_screen.dart';
import 'package:flutter_application_1/presentation/store/main_store.dart';

class MainBottomScreen extends StatefulWidget {
  final int initialTabIndex;

  const MainBottomScreen({Key? key, this.initialTabIndex = 0}) : super(key: key);

  @override
  State<MainBottomScreen> createState() => _MainBottomScreenState();
}

class _MainBottomScreenState extends State<MainBottomScreen> {
  final MainBottomStore store = MainBottomStore();
  

  @override
  void initState() {
    super.initState();
    store.setTabIndex(widget.initialTabIndex);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> mainPages = [
      HomeScreen(),
      CalendarScreen(),
      StatisticalScreen(),
      SettingScreen(),
    ];

    return Observer(
      builder: (_) => Scaffold(
        body: mainPages[store.selectedTabIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: store.selectedTabIndex,
          onTap: (index) => store.setTabIndex(index),
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
            BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Lịch'),
            BottomNavigationBarItem(icon: Icon(Icons.assessment), label: 'Thống kê'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Cài đặt'),
          ],
        ),
      ),
    );
  }
}
