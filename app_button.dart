// import 'package:brahmin/utilities/app_font.dart';
import 'package:cableproject/utilities/app_font.dart';
import 'package:flutter/material.dart';

import '../utilities/app_color.dart';

class AppButton extends StatelessWidget {
  final String text;
  final Function onPress;

  const AppButton({Key? key, required this.text, required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPress();
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 40 / 100,
        height: MediaQuery.of(context).size.height * 6 / 100,
        decoration: const BoxDecoration(
          color: AppColor.bluecolor,
          // color: AppColor.themeColor,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 19,
            fontFamily: AppFont.fontFamily2,
          ),
        ),
      ),
    );
  }
}

class AppButton2 extends StatelessWidget {
  final String text;
  final Function onPress;

  const AppButton2({Key? key, required this.text, required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPress();
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 70 / 100,
        height: MediaQuery.of(context).size.height * 7 / 100,
        decoration: const BoxDecoration(
          color: AppColor.redColor,
          // color: AppColor.themeColor,
          borderRadius: BorderRadius.all(Radius.circular(100)),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(
            color: AppColor.secondryColor,
            fontFamily: AppFont.fontFamily3,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
