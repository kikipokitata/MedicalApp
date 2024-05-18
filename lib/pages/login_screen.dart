
import 'package:flutter/material.dart';
import 'package:medical_app/data/events_data.dart';
import 'package:medical_app/pages/main_screen.dart';
import 'package:medical_app/pages/testBD.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../design/colors.dart';
import '../../design/styles.dart';
import '../data/data_user.dart';
import '../data/database_service.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: primary500,
        automaticallyImplyLeading: false,
        title: const Text(
          'Личный кабинет',
          style: appbarTextStyle,
        ),
      ),
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 400),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Вход',
                    style: titleStyle,
                  ),
                ],
              ),
              SizedBox(height: 20),
              TextField(
                controller: _loginController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Введите логин',
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Введите пароль',
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: customButtonStyle,
                onPressed: () {
                  _login(context);
                },
                child: const Text(
                  'Войти по паролю или ETU ID',
                  style: textOnButtonStyle,
                ),
              ),
              InkWell(
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Забыли пароль?',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                onTap: () =>
                    launchUrlString('https://lk.etu.ru/password/reset'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _login(BuildContext context) async {
    String email = _loginController.text.trim();
    String password = _passwordController.text.trim();
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      currentUid = userCredential.user!.uid;
      try {
        await DatabaseService().getUserDataByUid(currentUid);
      } catch (e) {
        print("Произошла ошибка при получении данных пользователя: $e");
        print("10");
      }
      print("11");

      String? userCourse = DatabaseService().userData.course;
      print(userCourse);
      if (userCourse != null) {
        await DatabaseService().getEventsByCourse(userCourse);
      }
      print("13");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    } catch (e) {
      _showErrorDialog(context, e.toString());
    }
  }

  void _showErrorDialog(BuildContext context, String errorMessage) {
    print('Error during login: $errorMessage');

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ошибка'),
          content: Text('Неправильный логин или пароль. Попробуйте еще раз.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
