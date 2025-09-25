import 'package:flutter/material.dart';

class AppColor {
  static const Color themeColor = Color(0xff1C6EB6);
  static const Color primaryColor = Colors.black;
  static const Color greyLightColor = Color(0xffa7a7a7);
  static const Color textfilledColor = Color(0xff888686);
  static const Color greyColor = Color(0xff777777);
  static const Color grey2Color = Color(0xff6D6D6D);
  static const Color secondryColor = Colors.white;
  static const Color transparentColor = Colors.transparent;
  //  prachi
  static const Color blackColor = Color(0xff000000);
  static const Color bgColor = Color(0xff1C1C1C);
  static const Color containerColor = Color(0xff44799A);
  static const Color upload = Color(0xff3F51B5);
  static const Color h1 = Color(0xff8E8A8A);
  static const Color buttoncolor = Color(0xffececec);
  static const Color borderline = Color(0xff000000);
  static const Color linkline = Color(0xff3F51B5);
  static const Color bluecolor = Color.fromARGB(255, 27, 51, 189);

  static const Color fontcolor = Color(0xFF3D3D3D);
  static const Color bordercolor = Color(0xFF44799A);
  // static const Color redColor = Color(0xFFFF0000);
  static const Color redColor = Color(0xFFFFd51c2f);

  static const LinearGradient bgGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFD63A2E), // red-orange
      Color(0xFF3C3B92), // purple-blue
    ],
  );

  static const LinearGradient buttonGredient = LinearGradient(
    end: Alignment.centerLeft,
    begin: Alignment.centerRight,
    colors: [
      Color(0xFFD63A2E), // red-orange
      Color(0xFF3C3B92), // purple-blue
    ],
  );
}
