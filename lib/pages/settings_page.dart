import 'package:flutter/material.dart';

import '../design/colors.dart';
import '../design/styles.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary500,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Настройки', style: appbarTextStyle,),
      ),
      body: Center(
        child: Text('Здесь будет информация о н'),
      ),
    );
  }
}