import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/entities/User.dart';
import 'package:flutter_application_1/presentation/widgets/info_card.dart';
import 'package:flutter_application_1/utils/device/toast.dart';

class DetailProfile extends StatefulWidget {
  const DetailProfile({super.key, required this.user});

  final User user;

  @override
  State<DetailProfile> createState() => _DetailProfileState();
}

class _DetailProfileState extends State<DetailProfile> {
  @override
  Widget build(BuildContext context) {
    final user = widget.user;

    return Scaffold(
      appBar: AppBar(title: Text("Detail profile")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Avatar (nếu có)
            // CircleAvatar(
            //   radius: 50,
            //   backgroundImage: NetworkImage(user.avatarUrl),
            // ),
            SizedBox(height: 16),

            InfoCard(
              icon: Icons.person,
              title: "Họ và Tên",
              value: '${user.firstName} ${user.lastName}',
            ),
            InfoCard(
              icon: Icons.cake,
              title: "Tuổi",
              value:
                  user.dateOfBirth != null
                      ? (DateTime.now().year - user.dateOfBirth!.year)
                          .toString()
                      : "Không rõ",
            ),

            InfoCard(
              icon: Icons.phone,
              title: "Phone",
              value: user.phoneNumber ?? "Không có số",
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                showToast(
                  msg: "Chức năng đang phát triển",
                  backgroundColor: Colors.orange,
                  textColor: Colors.white,
                );
              },
              child: Text("Chỉnh sửa"),
            ),
          ],
        ),
      ),
    );
  }
}
