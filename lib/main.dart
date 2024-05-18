import 'package:flutter/material.dart';
import 'package:medical_app/pages/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: Colors.red,
      fontFamily: 'Arial',
    ),

    home: LoginScreen(),
  ));
}


