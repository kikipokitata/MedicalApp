import 'package:flutter/material.dart';

import '../design/colors.dart';
import '../design/styles.dart';

class PersonalDataPage extends StatelessWidget {
  const PersonalDataPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary500,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Личные данные', style: appbarTextStyle,),
      ),
      body: Center(
        child: Text('Здесь будут личные данные'),
      ),
    );
  }
}