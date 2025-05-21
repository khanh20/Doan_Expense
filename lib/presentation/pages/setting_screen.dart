import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/assets.dart';
import 'package:flutter_application_1/data/sharedpref/constants/preferences.dart';
import 'package:flutter_application_1/data/sharedpref/shared_preference_helper.dart';
import 'package:flutter_application_1/domain/entities/User.dart';
import 'package:flutter_application_1/presentation/pages/details_profile_screen.dart';
import 'package:flutter_application_1/presentation/widgets/section_title.dart';
import 'package:flutter_application_1/utils/device/toast.dart';
import 'package:flutter_application_1/utils/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  User? user;
  final assets = Assets();
  //stores:---------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final helper = SharedPreferenceHelper(prefs);
    final loadedUser = await helper.getUser();
    setState(() {
      user = loadedUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    void pending() {
      showToast(
        msg: ("Chức năng đang phát triển"),
        backgroundColor: Colors.orange[400],
        textColor: Colors.white,
      );
    }

    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailProfile(user: user!),
                    ),
                  );
                },
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(Assets().defaultAvatarUser),
                    ),
                    SizedBox(width: 35),

                    // Show profile căn giữa khoảng trống giữa title và icon
                    Expanded(
                      child: Text(
                        user?.firstName ?? "Người dùng",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios_rounded),
                  ],
                ),
              ),
            ),
            Divider(),
            Expanded(
              child: ListView(
                children: [
                  BuildSectionTitle(title: "Settings"),
                  ListTile(
                    leading: Icon(Icons.account_circle_outlined),
                    title: Text("Personal information"),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: pending,
                  ),
                  ListTile(
                    leading: Icon(Icons.security_outlined),
                    title: Text("Login & security"),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: pending,
                  ),
                  ListTile(
                    leading: Icon(Icons.payment_outlined),
                    title: Text("Payments and payouts"),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: pending,
                  ),
                  ListTile(
                    leading: Icon(Icons.settings_accessibility),
                    title: Text("Accessibility"),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: pending,
                  ),
                  ListTile(
                    leading: Icon(Icons.file_copy_outlined),
                    title: Text("Taxes"),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: pending,
                  ),
                  ListTile(
                    leading: Icon(Icons.translate),
                    title: Text("Translation"),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: pending,
                  ),
                  ListTile(
                    leading: Icon(Icons.notifications_outlined),
                    title: Text("Notifications"),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: pending,
                  ),
                  ListTile(
                    leading: Icon(Icons.lock_outline),
                    title: Text("Privacy and sharing"),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: pending,
                  ),
                  ListTile(
                    leading: Icon(Icons.luggage_outlined),
                    title: Text("Travel for work"),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: pending,
                  ),
                  Divider(),
                  BuildSectionTitle(title: "Support"),
                  ListTile(
                    leading: Icon(Icons.help_outline_sharp),
                    title: Text("Visit the Help Center"),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: pending,
                  ),
                  ListTile(
                    leading: Icon(Icons.shield_outlined),
                    title: Text("Get help with a safety issue"),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: pending,
                  ),

                  ListTile(
                    leading: Icon(Icons.menu_book_sharp),
                    title: Text('Privacy Policy'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: pending,
                  ),

                  Divider(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // app bar methods:-----------------------------------------------------------
  PreferredSizeWidget _buildAppBar() {
    return AppBar(title: Text("Cài đặt"), actions: _buildActions(context));
  }

  List<Widget> _buildActions(BuildContext context) {
    return <Widget>[_buildLogoutButton()];
  }

  Widget _buildLogoutButton() {
    return IconButton(
      onPressed: () {
        SharedPreferences.getInstance().then((preference) {
          preference.setBool(Preferences.is_logged_in, false);
          Navigator.of(context).pushReplacementNamed(Routes.login);
        });
      },
      icon: Icon(Icons.power_settings_new),
    );
  }
}
