import 'package:flutter/material.dart';
import '../../design/colors.dart';

final ButtonStyle customButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: primary500,
  foregroundColor: primary900,
  splashFactory: NoSplash.splashFactory,
  minimumSize: Size(50, 50),
  padding: EdgeInsets.only(left: 35, right: 35, top: 10, bottom: 10),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
  ),
);

final ButtonStyle customButton2Style = ElevatedButton.styleFrom(
  backgroundColor: primary100,
  foregroundColor: primary300,
  elevation: 0,
  splashFactory: NoSplash.splashFactory,
  minimumSize: Size(50, 50),
  padding: EdgeInsets.only(left: 35, right: 35, top: 10, bottom: 10),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
  ),
);

const TextStyle appbarTextStyle = TextStyle(
  color: primary50,
  fontSize: 25,
  fontWeight: FontWeight.w500,
);

const TextStyle textOnButtonStyle = TextStyle(
    color: primary50,
    fontSize: 20,
    fontWeight: FontWeight.w400
);

const TextStyle textOnButton2Style = TextStyle(
    color: primary800,
    fontSize: 17,
    fontWeight: FontWeight.w400
);


const TextStyle titleStyle = TextStyle(
  color: primary700,
  fontSize: 30,
  fontWeight: FontWeight.w500,

);

const TextStyle titleDocumentStyle = TextStyle(
color: primary900,
fontSize: 16,
fontWeight: FontWeight.w300,
);


