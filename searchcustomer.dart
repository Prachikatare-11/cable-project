import 'package:cableproject/utilities/app_button.dart';
import 'package:cableproject/utilities/app_color.dart';
import 'package:cableproject/utilities/app_constant.dart';
import 'package:cableproject/utilities/app_font.dart';
import 'package:cableproject/utilities/app_image.dart';
import 'package:cableproject/utilities/app_language.dart';
import 'package:cableproject/view/authentication/Home.dart';
import 'package:cableproject/view/authentication/login.dart';
import 'package:cableproject/view/authentication/payment.dart';
import 'package:cableproject/view/authentication/paymenthistory.dart';
import 'package:cableproject/view/authentication/view-unpaid-customer.dart';
import 'package:cableproject/view/authentication/viewallcustomers.dart';
import 'package:cableproject/view/authentication/viewpaid.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Searchcustomer extends StatefulWidget {
  const Searchcustomer({super.key});

  @override
  State<Searchcustomer> createState() => _SearchCustomerState();
}

class _SearchCustomerState extends State<Searchcustomer> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<dynamic> selectedRole = <dynamic>[
    {"id": 1, "member": "Customer id"},
    {"id": 2, "member": "Mobile No"},
    {"id": 3, "member": "Area"},
    {"id": 4, "member": "Name"},
    {"id": 5, "member": "Address"},
  ];

  int? selectedId;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: AppColor.primaryColor,
        statusBarIconBrightness: Brightness.light));

    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            NoInternetBanner(),
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: AppColor.buttonGredient,
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  AppLanguage.cable[language],
                  style: const TextStyle(
                      color: Color.fromARGB(255, 190, 74, 66),
                      fontSize: 44,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            ListTile(
              leading: SizedBox(
                  height: MediaQuery.of(context).size.height * 9 / 100,
                  width: MediaQuery.of(context).size.width * 10 / 100,
                  child: Image.asset(AppImage.homeicon)),
              title: Text(
                AppLanguage.homeText[language],
                style: TextStyle(
                    fontFamily: AppFont.fontFamily2,
                    color: AppColor.bgColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Home(),
                  ),
                );
              },
            ),
            ListTile(
              leading: SizedBox(
                  height: MediaQuery.of(context).size.height * 7 / 100,
                  width: MediaQuery.of(context).size.width * 9 / 100,
                  child: Image.asset(AppImage.iconview)),
              title: Text(
                AppLanguage.search[language],
                style: TextStyle(
                    fontFamily: AppFont.fontFamily2,
                    color: AppColor.bgColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Searchcustomer(),
                  ),
                );
              },
            ),
            ListTile(
              leading: SizedBox(
                  height: MediaQuery.of(context).size.height * 7 / 100,
                  width: MediaQuery.of(context).size.width * 9 / 100,
                  child: Image.asset(AppImage.iconview)),
              title: Text(
                AppLanguage.view[language],
                style: TextStyle(
                    fontFamily: AppFont.fontFamily2,
                    color: AppColor.bgColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewUnpaidCustomer(),
                  ),
                );
              },
            ),
            ListTile(
              leading: SizedBox(
                  height: MediaQuery.of(context).size.height * 7 / 100,
                  width: MediaQuery.of(context).size.width * 9 / 100,
                  child: Image.asset(AppImage.iconview)),
              title: Text(
                AppLanguage.paid[language],
                style: TextStyle(
                    fontFamily: AppFont.fontFamily2,
                    color: AppColor.bgColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewpaidCustomer(),
                  ),
                );
              },
            ),
            ListTile(
              leading: SizedBox(
                  height: MediaQuery.of(context).size.height * 7 / 100,
                  width: MediaQuery.of(context).size.width * 9 / 100,
                  child: Image.asset(AppImage.iconview)),
              title: Text(
                AppLanguage.viewall[language],
                style: TextStyle(
                    fontFamily: AppFont.fontFamily2,
                    color: AppColor.bgColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => viewallcustomers(),
                  ),
                );
              },
            ),
            ListTile(
              leading: SizedBox(
                  height: MediaQuery.of(context).size.height * 7 / 100,
                  width: MediaQuery.of(context).size.width * 9 / 100,
                  child: Image.asset(AppImage.iconview)),
              title: Text(
                AppLanguage.today[language],
                style: TextStyle(
                    fontFamily: AppFont.fontFamily2,
                    color: AppColor.bgColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
              ),
              onTap: () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Paymenthistory(userId: '', customerId: '', connectionId: '',),
                  ),
                );
              },
            ),
            ListTile(
              leading: SizedBox(
                  height: MediaQuery.of(context).size.height * 7 / 100,
                  width: MediaQuery.of(context).size.width * 9 / 100,
                  child: Image.asset(AppImage.iconview)),
              title: Text(
                AppLanguage.reminder[language],
                style: TextStyle(
                    fontFamily: AppFont.fontFamily2,
                    color: AppColor.bgColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
                leading: SizedBox(
                    height: MediaQuery.of(context).size.height * 7 / 100,
                    width: MediaQuery.of(context).size.width * 9 / 100,
                    child: Image.asset(AppImage.iconlogout)),
                title: Text(
                  AppLanguage.logoutText[language],
                  style: TextStyle(
                      fontFamily: AppFont.fontFamily2,
                      color: AppColor.bgColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                ),
                onTap: () {
                  logOutPopUp(context);
                }),
          ],
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Column(children: [
        Container(
          height: MediaQuery.of(context).size.height * 7 / 100,
          width: MediaQuery.of(context).size.width,
          color: AppColor.redColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NoInternetBanner(),
              Container(
                height: MediaQuery.of(context).size.height * 6 / 100,
                width: MediaQuery.of(context).size.width * 90 / 100,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _scaffoldKey.currentState?.openDrawer();
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 7 / 100,
                        child: Image.asset(AppImage.mainicon),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 2 / 100),
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 65 / 100,
            child: Text(
              AppLanguage.searchcustomer[language],
              style: TextStyle(
                fontSize: 18,
                color: AppColor.primaryColor,
                fontWeight: FontWeight.w400,
                fontFamily: AppFont.fontFamily,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 2 / 100),
        SizedBox(
          width: MediaQuery.of(context).size.width * 90 / 100,
          child: Wrap(
            spacing: MediaQuery.of(context).size.width * 4 / 100,
            runSpacing: MediaQuery.of(context).size.height * 1 / 100,
            children: selectedRole.map((item) {
              return SizedBox(
                width: MediaQuery.of(context).size.width * 40 / 100,
                child: Container(
                  height: MediaQuery.of(context).size.height * 5 / 100,
                  color: AppColor.buttoncolor,
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedId = item["id"];
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Radio<int>(
                          value: item["id"],
                          groupValue: selectedId,
                          onChanged: (value) {
                            setState(() {
                              selectedId = value!;
                            });
                          },
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 25 / 100,
                          child: Text(
                            item["member"],
                            style: TextStyle(
                              fontFamily: AppFont.fontFamily,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 4 / 100),
        SizedBox(
          width: MediaQuery.of(context).size.width * 90 / 100,
          height: MediaQuery.of(context).size.height * 6 / 100,
          child: TextField(
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              hintText: AppLanguage.search2[language],
              hintStyle: TextStyle(
                color: AppColor.textfilledColor,
                fontFamily: AppFont.fontFamily,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColor.redColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColor.redColor),
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(
                  AppImage.searchicon,
                  width: MediaQuery.of(context).size.width * 6 / 100,
                  height: MediaQuery.of(context).size.height * 10 / 100,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 2 / 100),
        AppButton2(
          text: AppLanguage.searchbutton[language],
          onPress: () {},
        ),
      ]))),
    );
  }
}

// logOutPopUp(context);
void logOutPopUp(BuildContext context) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColor.primaryColor.withOpacity(0.1),
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 100 / 100,
              height: MediaQuery.of(context).size.height * 100 / 100,
              color: AppColor.primaryColor.withOpacity(0.1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 82 / 100,
                        padding: const EdgeInsets.symmetric(
                            vertical: 35, horizontal: 15),
                        decoration: BoxDecoration(
                            color: AppColor.secondryColor,
                            borderRadius: BorderRadius.circular(0)),
                        child: Column(
                          children: [
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 1 / 100,
                            ),
                            Center(
                              child: Text(
                                AppLanguage.logoutModelText[language],
                                style: const TextStyle(
                                    color: AppColor.primaryColor,
                                    fontFamily: AppFont.fontFamily,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20),
                              ),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 1 / 100,
                            ),
                            Container(
                              width:
                                  MediaQuery.of(context).size.width * 60 / 100,
                              child: Text(
                                AppLanguage.sureLogOuttext[language],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: AppColor.bgColor,
                                    fontFamily: AppFont.fontFamily,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 3 / 100,
                            ),
                            Container(
                              width:
                                  MediaQuery.of(context).size.width * 82 / 100,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          30 /
                                          100,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              5 /
                                              100,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColor.themeColor),
                                          borderRadius:
                                              BorderRadius.circular(29)),
                                      child: Text(
                                        AppLanguage.noText[language],
                                        style: const TextStyle(
                                            color: AppColor.themeColor,
                                            fontFamily: AppFont.fontFamily,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        7 /
                                        100,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      Navigator.pop(context);

                                      final prefs =
                                          await SharedPreferences.getInstance();

                                      final Mobile = prefs.getString("mobile");
                                      final password =
                                          prefs.getString("password");
                                      final rememberMe =
                                          prefs.getBool("rememberMe") ?? false;

                                      print("Response --> $Mobile");
                                      print("Response --> $password");
                                      await prefs.setBool("isLoggedIn", false);
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Login()),
                                        (Route<dynamic> route) => false,
                                      );
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          30 /
                                          100,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              5 /
                                              100,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: AppColor.themeColor,
                                        borderRadius: BorderRadius.circular(29),
                                      ),
                                      child: Text(
                                        AppLanguage.yesText[language],
                                        style: const TextStyle(
                                          color: AppColor.secondryColor,
                                          fontFamily: AppFont.fontFamily,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Positioned(
                      //   top: 0,
                      //   child: Container(
                      //     width: MediaQuery.of(context).size.width * 82 / 100,
                      //     height:
                      //         MediaQuery.of(context).size.height * 1.2 / 100,
                      //     color: AppColor.themeColor,
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
      });
}
