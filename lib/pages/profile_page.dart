import 'package:firebase_auth/firebase_auth.dart';
// FirebaseAuth.instance.currentUser?.uid ?? ""
import 'package:flutter/material.dart';
import 'package:medical_app/design/colors.dart';
import 'package:medical_app/pages/login_screen.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../design/styles.dart';
import '../data/data_user.dart';
import 'personal_data_page.dart';
import 'support_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatelessWidget {
  final UserData currentUser;

  const ProfilePage({Key? key, required this.currentUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: [
                // Изображение пользователя с рамкой
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: primary200, // Цвет рамки
                      width: 3, // Ширина рамки
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 80, // Радиус изображения
                    backgroundImage: currentUser.photoUrl != null && currentUser.photoUrl!.isNotEmpty
                        ? NetworkImage(currentUser.photoUrl!)
                        : null,
                    backgroundColor: Colors.transparent,
                  ),
                ),
                SizedBox(width: 16),
                // ФИО
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${currentUser.lastName ?? ''}',
                        style: titleStyle,
                      ),
                      Text(
                        '${currentUser.firstName ?? ''}',
                        style: titleStyle,
                      ),
                      Text(
                        '${currentUser.fatherName ?? ''}',
                        style: titleStyle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: customButton2Style,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PersonalDataPage()),
                );
              },
              child: const Text('Личные данные', style: textOnButton2Style),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: customButton2Style,
              child: InkWell(
                splashFactory: NoSplash.splashFactory,
                child: const Padding(
                  padding: EdgeInsets.zero,
                  child: Text('Политика безопасности', style: textOnButton2Style,),
                ),
                onTap: () => launchUrlString(
                    'https://lk.etu.ru/assets/files/politika-v-otnoshenii-personalnyh-dannyh.pdf'),
              ),
              onPressed: () {},
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: customButton2Style,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SupportPage()),
                );
              },
              child: const Text('Поддержка', style: textOnButton2Style),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: customButtonStyle,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: const Text('Выход из аккаунта', style: textOnButtonStyle),
            ),
          ],
        ),
      ),
    );
  }
}

