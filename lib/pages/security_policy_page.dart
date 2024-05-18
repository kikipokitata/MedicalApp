import 'package:flutter/material.dart';

import '../design/colors.dart';
import '../design/styles.dart';

class SecurityPolicyPage extends StatelessWidget {
  const SecurityPolicyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary500,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Политика безопасности', style: appbarTextStyle,),
      ),
      body: Center(
        child: Text('Здесь будет политика безопасности'),
      ),
    );
  }
}