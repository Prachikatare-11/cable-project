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
import 'package:cableproject/view/authentication/Home.dart';
import 'package:cableproject/view/authentication/forgotpassword.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  bool rememberMe = false;
  final userDetails = [];

  @override
  void initState() {
    super.initState();
    loadSavedCredentials();
  }

  void loadSavedCredentials() async {
    final pref = await SharedPreferences.getInstance();
    bool isRemembered = pref.getBool("rememberMe") ?? false;

    if (isRemembered) {
      setState(() {
        phoneTextEditingController.text = pref.getString("mobile") ?? "";
        passwordTextEditingController.text = pref.getString("password") ?? "";
        rememberMe = true;
      });
    }
  }

  bool isRemembered = false;

  loginUser(String password, String mobile) {
    if (mobile.isEmpty) {
      SnackBarToastMessage.showSnackBar(
          context, AppLanguage.emailvalidtaion[language]);
    } else if (mobile.length < 7 || mobile.length > 15) {
      SnackBarToastMessage.showSnackBar(
          context, AppLanguage.mobilevalidation[language]);
    } else if (password.isEmpty) {
      SnackBarToastMessage.showSnackBar(
          context, AppLanguage.passwordvalidation[language]);
    } else if (password.length <= 5) {
      SnackBarToastMessage.showSnackBar(
          context, AppLanguage.passwordfiledvalidation[language]);
    } else {
      loginApiCalling(mobile, password);
    }
  }

  loginApiCalling(String mobile, String password) async {
    final url =
        Uri.parse("https://sairamcable.in/cb_cable/newapp_api/login.php");
    final Map<String, String> body = {
      'mobile': mobile,
      'password': password,
      'flag': '3',
    };

    try {
      final request = http.MultipartRequest("POST", url);
      request.fields.addAll(body);
      print("URI --> $url");
      final streamResponse = await request.send();
      final byteResponse = await streamResponse.stream.toBytes();
      final utf8Response = utf8.decode(byteResponse);

      final response = jsonDecode(utf8Response);
      print("Request --> ${request.fields}");

      if (streamResponse.statusCode == 200) {
        print("Response --> $response");
        if (response['success'] == "true") {
          final pref = await SharedPreferences.getInstance();

          if (rememberMe) {
            await pref.setString("mobile", (mobile.toString()));
            await pref.setString("password", (password.toString()));

            print("Response --> $password");
            print("Response --> $mobile");
            await pref.setBool("rememberMe", true);
          } else {
            await pref.remove("mobile");
            await pref.remove("password");

            await pref.setBool("rememberMe", false);
          }
          await pref.setString("user_id", (response['user_id'].toString()));
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );
        } else {
          SnackBarToastMessage.showSnackBar(context, response['msg']);
        }
      }
    } catch (e) {
      print("Login error: $e");
      SnackBarToastMessage.showSnackBar(
          context, "Something went wrong. Try again!");
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColor.primaryColor,
      statusBarIconBrightness: Brightness.light,
    ));

    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            body: SafeArea(
                child: Column(children: [
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  color: AppColor.secondryColor,
                ),
                child: Column(
                  children: [
                    NoInternetBanner(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5 / 100,
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 1 / 100),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 60 / 100,
                        child: Text(
                          AppLanguage.collection[language],
                          style: TextStyle(
                            fontSize: 30,
                            color: AppColor.primaryColor,
                            fontWeight: FontWeight.w500,
                            fontFamily: AppFont.fontFamily,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 2 / 100,
                          ),
                          Image.asset(
                            AppImage.cableicon,
                            width: MediaQuery.of(context).size.width * 80 / 100,
                            height:
                                MediaQuery.of(context).size.height * 30 / 100,
                            fit: BoxFit.fitWidth,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2 / 100,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        child: Text(
                          AppLanguage.mobileNumberMessage[language],
                          style: TextStyle(
                            fontSize: 20,
                            color: AppColor.bgColor,
                            fontWeight: FontWeight.w400,
                            fontFamily: AppFont.fontFamily,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2 / 100,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 3 / 100,
                    ),
                    CustomInputTextField(
                      controller: phoneTextEditingController,
                      hintText: AppLanguage.phone[language],
                      keyboardtype: TextInputType.number,
                      maxLength: 10,
                      readOnly: false,
                      prefixIcon: AppImage.call,
                      cursorColor: AppColor.redColor,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2 / 100,
                    ),
                    CustomInputTextField(
                      controller: passwordTextEditingController,
                      hintText: AppLanguage.password[language],
                      keyboardtype: TextInputType.name,
                      maxLength: 15,
                      readOnly: false,
                      prefixIcon: AppImage.iconpass,
                      cursorColor: AppColor.redColor,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 46 / 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Checkbox(
                              value: rememberMe,
                              activeColor: AppColor.bluecolor,
                              onChanged: (value) {
                                setState(() {
                                  rememberMe = value ?? true;
                                  print("Remember Me: $rememberMe");
                                });
                              },
                            ),
                            Text(
                              AppLanguage.rememberMeText[language],
                              style: TextStyle(
                                fontSize: 15,
                                color: AppColor.bluecolor,
                                fontWeight: FontWeight.w400,
                                fontFamily: AppFont.fontFamily,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 1 / 100,
                    ),
                    AppButton(
                      text: AppLanguage.loginButtonText[language],
                      onPress: () {
                        loginUser(passwordTextEditingController.text.trim(),
                            phoneTextEditingController.text.trim());
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 4 / 100,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]))));
  }
}
