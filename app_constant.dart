import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'app_color.dart';
import 'app_connectivity.dart';
import 'app_font.dart';
import 'app_language.dart';

int language = 0;

class AppConstant {
  static const int appStatus = 0;
  static String token = '';
  static const TextStyle appBarTitleStyle = TextStyle(
    fontSize: 22,
    color: Colors.black,
    fontWeight: FontWeight.w600,
  );
  static final RegExp emailValidatorRegExp =
      RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  static const TextStyle textFilledStyle = TextStyle(
      color: AppColor.textfilledColor,
      fontWeight: FontWeight.w500,
      fontSize: 14);
  // Defination of max length
  static const int emailMaxLength = 50;
  static const int passwordMaxLength = 16;
  static const int fullNameText = 50;
  static const int mobileMaxLenth = 15;
  static const int messageMaxLenth = 250;
  static var deviceType = Platform.operatingSystem;

  static const TextStyle textFilledHeading =
      TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500);
  static const SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
  );
}

class SuccessClass {
  final String title;
  final String message;

  SuccessClass({required this.title, required this.message});
}

enum BottomMenus { notification, home, profile }

class NoInternetBanner extends StatelessWidget {
  const NoInternetBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var connectionProvider = Provider.of<ConnectionProvider>(context);

    if (connectionProvider.status.name == "WiFi" ||
        connectionProvider.status.name == "Mobile") {
      return const SizedBox();
    }

    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 7 / 100,
          width: double.infinity,
          alignment: Alignment.centerLeft,
          color: Colors.red,
          child: Padding(
            padding: const EdgeInsets.only(left: 11),
            child: Text(
              AppLanguage.noInternetText[language],
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                fontFamily: AppFont.fontFamily,
                color: AppColor.secondryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
