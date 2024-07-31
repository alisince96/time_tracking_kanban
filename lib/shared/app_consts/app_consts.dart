import 'package:flutter/material.dart';

class AppConsts {
  static const String font1 = 'Helvetica';
  static const Color splashColor = Color(0xFFFEC356);

  static const Color greenish = Color(0xFF74BE3F);

  static const Color greyish = Color(0xFF54595F);
  static const Color appGrey = Color.fromARGB(255, 228, 233, 239);

  static const Color darkBlue = Color(0xFF1B4192);

  static const Color lightRed = Color(0xFFE5221E);
  static const Color black = Colors.black;

  static const Color white = Colors.white;

  static const TextStyle whiteBold50 = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 50.0,
    fontFamily: 'MontserratSemibold',
  );

  static const TextStyle greyishNormal = TextStyle(
      color: AppConsts.greyish,
      fontWeight: FontWeight.normal,
      fontFamily: 'Montserrat',
      fontSize: 14);

  static const TextStyle blackBold = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 18,
      fontFamily: 'MontserratSemibold');

  static const TextStyle blackNormal15 = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w300,
      fontSize: 13.0,
      fontFamily: 'Montserrat');
  static const TextStyle greyNormal15 = TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.w300,
      fontSize: 13.0,
      fontFamily: 'Montserrat');

  static TextStyle black26Normal15 = const TextStyle(
      color: Colors.black45,
      fontWeight: FontWeight.w400,
      fontSize: 10.0,
      fontFamily: 'Montserrat');
  static const TextStyle blackNormal25 = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w400,
      fontSize: 17.0,
      fontFamily: 'Montserrat');

  static const TextStyle whiteNormal25 = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w400,
      fontSize: 17.0,
      fontFamily: 'Montserrat');
}
