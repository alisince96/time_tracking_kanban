import 'package:flutter/material.dart';

class AppConsts {
  static const String projectId = '2336970909';
  static const String todoSectionId = '162107011';
  static const String progressSectionId = '162107095';
  static const String doneSectionId = '162107133';
  static const String font1 = 'Helvetica';
  static const Color splashColor = Color(0xFFFEC356);
  static const Color darkYellowish = Color(0xFFC4C4C4);
  static const Color greyishColor = Color(0xFFEDEDED);
  static const Color greenish = Color(0xFF74BE3F);
  static const Color darkGreenish = Color(0xFF28AB6F);
  static const Color brownish = Color(0xFF865136);
  static const Color greyish = Color(0xFF54595F);
  static const Color appGrey = Color.fromARGB(255, 228, 233, 239);

  static LinearGradient appGradient = const LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: <Color>[Color(0xFF28AB6F), AppConsts.greenish]);
  static LinearGradient drawerGradient = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: <Color>[AppConsts.greenish, Color(0xFF4EAE92)]);
  static const Color greyBorder = Color(0xFFF5F5F5);
  static const Color creamy = Color(0xFFC27A1D);
  static const Color lightCreamy = Color(0xFFFFC222);
  static const Color darkBlue = Color(0xFF1B4192);
  static const Color brown1 = Color(0xFFEECE7C);
  static const Color lightRed = Color(0xFFE5221E);
  static const Color black = Colors.black;
  static const Color grey = Color(0xFFEDEDED);
  static const Color white = Colors.white;
  static Color blue = const Color(0xFF0661AA);
  static const TextStyle whiteBold50 = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 50.0,
    fontFamily: 'MontserratSemibold',
  );
  static const TextStyle blackw800 = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w800,
      fontFamily: 'Montserrat',
      fontSize: 18);
  static const TextStyle blueNormal = TextStyle(
      color: Colors.blue,
      fontWeight: FontWeight.w800,
      fontFamily: 'Montserrat',
      fontSize: 18);
  static const TextStyle greyishNormal = TextStyle(
      color: AppConsts.greyish,
      fontWeight: FontWeight.normal,
      fontFamily: 'Montserrat',
      fontSize: 14);
  static const TextStyle greyishBold = TextStyle(
      color: AppConsts.greyish,
      fontWeight: FontWeight.bold,
      fontFamily: 'MontserratSemibold',
      fontSize: 14);
  static const TextStyle greyw800 = TextStyle(
      color: AppConsts.greyishColor,
      fontWeight: FontWeight.w800,
      fontFamily: 'Montserrat',
      fontSize: 18);
  static TextStyle realgreyw800 = TextStyle(
      color: Colors.grey[350],
      fontWeight: FontWeight.w800,
      fontFamily: 'Montserrat',
      fontSize: 18);
  static const TextStyle blackBold = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 18,
      fontFamily: 'MontserratSemibold');
  static const TextStyle blackSemiBold = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w600,
      fontSize: 18,
      fontFamily: 'MontserratSemibold');
  static const TextStyle blackSemiBold14 = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w500,
      fontSize: 14,
      fontFamily: 'MontserratSemibold');
  static const TextStyle blackw60040 = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w300,
      fontSize: 40.0,
      fontFamily: 'Montserrat');
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
  static const TextStyle greenNormal15 = TextStyle(
      color: AppConsts.greenish,
      fontWeight: FontWeight.w300,
      fontSize: 13.0,
      fontFamily: 'Montserrat');
  static const TextStyle greenBold = TextStyle(
      color: AppConsts.greenish,
      fontWeight: FontWeight.w800,
      fontSize: 13.0,
      fontFamily: 'MontserratSemibold');
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
  static const TextStyle splashNormal25 = TextStyle(
      color: AppConsts.splashColor,
      fontWeight: FontWeight.w400,
      fontSize: 17.0,
      fontFamily: 'Montserrat');
  static const TextStyle whiteNormal25 = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w400,
      fontSize: 17.0,
      fontFamily: 'Montserrat');
  static const TextStyle brownishNormal25 = TextStyle(
      color: AppConsts.brownish,
      fontWeight: FontWeight.w400,
      fontSize: 17.0,
      fontFamily: 'Helvetica');

  static const TextStyle blackw40018 = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w400,
      fontSize: 13.0,
      fontFamily: 'Montserrat');
  static const TextStyle blackw40012 = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w400,
      fontSize: 12.0,
      fontFamily: 'Montserrat');
  static const LinearGradient backgroundGradient = LinearGradient(
      colors: [AppConsts.brown1, AppConsts.splashColor],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);
}
