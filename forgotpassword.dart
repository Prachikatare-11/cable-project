import 'dart:convert';

import 'package:cableproject/utilities/Custom_inputtextfeild.dart';
import 'package:cableproject/utilities/app_button.dart';
import 'package:cableproject/utilities/app_color.dart';
import 'package:cableproject/utilities/app_config_provider.dart';
import 'package:cableproject/utilities/app_constant.dart';
import 'package:cableproject/utilities/app_font.dart';
import 'package:cableproject/utilities/app_image.dart';
import 'package:cableproject/utilities/app_language.dart';
import 'package:cableproject/utilities/app_snackbar_toast_message.dart';
import 'package:cableproject/view/authentication/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => ForgotPasswordState();
}

class ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController phoneTextEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColor.bgColor,
      statusBarIconBrightness: Brightness.light,
    ));
  }

  validate(String mobile) {
    if (mobile.isEmpty) {
      SnackBarToastMessage.showSnackBar(
          context, "Please enter a mobile number");
    } else if (mobile.length < 7 || mobile.length > 15) {
      SnackBarToastMessage.showSnackBar(context, "Enter a valid mobile number");
    } else {
      // forgotApiCalling(mobile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  NoInternetBanner(),
                  Container(
                    height: MediaQuery.of(context).size.height * 7 / 100,
                    width: double.infinity,
                    color: AppColor.redColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.width * 8 / 100,
                            width: MediaQuery.of(context).size.width * 14 / 100,
                            child: Image.asset(AppImage.iconbutton),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 2 / 100),
                  Text(
                    AppLanguage.forgotPassword[language],
                    style: TextStyle(
                      fontFamily: AppFont.fontFamily2,
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 65 / 100,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          AppImage.cableicon,
                          width: MediaQuery.of(context).size.width * 80 / 100,
                          height: MediaQuery.of(context).size.height * 30 / 100,
                          fit: BoxFit.fitWidth,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    AppLanguage.mobileNumberMessage[language],
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: AppFont.fontFamily2,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 6 / 100),
                  // SizedBox(
                  //   width: MediaQuery.of(context).size.width * 90 / 100,
                  //   height: MediaQuery.of(context).size.height * 6 / 100,
                  //   child: TextField(
                  //     // readOnly: true,
                  //     decoration: InputDecoration(
                  //       hintText: AppLanguage.mobileNumberMessage[language],
                  //       hintStyle: TextStyle(
                  //         color: AppColor.bgColor,
                  //         fontFamily: AppFont.fontFamily2,
                  //         fontWeight: FontWeight.w500,
                  //         fontSize: 18,
                  //       ),
                  //       prefixIcon: Padding(
                  //         padding: const EdgeInsets.all(14.0),
                  //         child: Image.asset(
                  //           AppImage.call,
                  //           width: MediaQuery.of(context).size.width * 4 / 100,
                  //           height: MediaQuery.of(context).size.height * 9 / 100,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  CustomInputTextField(
                    controller: phoneTextEditingController,
                    hintText: AppLanguage.phone[language],
                    keyboardtype: TextInputType.number,
                    maxLength: 50,
                    readOnly: false,
                    prefixIcon: AppImage.call,
                    cursorColor: AppColor.redColor,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 6 / 100),
                  AppButton(
                      text: AppLanguage.sendButtonText[language],
                      onPress: () {
                        validate(phoneTextEditingController.text.trim());
                      })
                ],
              ),
            ),
          ),
        ));
  }
}
