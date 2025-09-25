import 'package:cableproject/utilities/app_button.dart';
import 'package:cableproject/utilities/app_color.dart';
import 'package:cableproject/utilities/app_constant.dart';
import 'package:cableproject/utilities/app_font.dart';
import 'package:cableproject/utilities/app_language.dart';
import 'package:cableproject/view/authentication/Home.dart';
import 'package:cableproject/view/authentication/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utilities/app_image.dart';

class NotificationPage extends StatefulWidget {
  static String routeName = './notification';
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text(
              AppLanguage.welcometext2[language],
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontFamily: AppFont.fontFamily2,
                fontSize: 18,
              ),
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 90 / 100,
              height: MediaQuery.of(context).size.height * 8 / 100,
              child: Center(
                child: SizedBox(
                  child: Text(
                    AppLanguage.internettext[language],
                    style: TextStyle(
                      fontSize: 13,
                      fontFamily: AppFont.fontFamily2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            actions: [
              AppButton2(
                  text: AppLanguage.okbutton[language],
                  onPress: () {
                    // Navigator.pop(context);
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  })
            ],
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(),
    ));
  }
}
