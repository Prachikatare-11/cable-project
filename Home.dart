import 'dart:convert';
import 'package:cableproject/utilities/app_button.dart';
import 'package:cableproject/utilities/app_color.dart';
import 'package:cableproject/utilities/app_constant.dart';
import 'package:cableproject/utilities/app_font.dart';
import 'package:cableproject/utilities/app_image.dart';
import 'package:cableproject/utilities/app_language.dart';
import 'package:cableproject/utilities/app_loader.dart';
import 'package:cableproject/view/authentication/forgotpassword.dart';
import 'package:cableproject/view/authentication/login.dart';
import 'package:cableproject/view/authentication/notification.dart';
import 'package:cableproject/view/authentication/payment.dart';
import 'package:cableproject/view/authentication/paymenthistory.dart';
import 'package:cableproject/view/authentication/searchcustomer.dart';
import 'package:cableproject/view/authentication/view-unpaid-customer.dart';
import 'package:cableproject/view/authentication/viewallcustomers.dart';
import 'package:cableproject/view/authentication/viewpaid.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import '../../utilities/app_config_provider.dart';
import '../../utilities/app_snackbar_toast_message.dart';

class Home extends StatefulWidget {
  static String routeName = './Home';

  const Home({super.key});

  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  dynamic? selectedCity;
  String? userId = "";
  String prev_remaining_amount = '';
  String get_total_collect_amt = '';
  String get_total_adv_collect_amt = '';
  String get_total_billing_amt = '';
  // String getall_lines = '';
  int lineId = 0;

  bool isAPICalling = false;
  bool isAPICallingShimmer = true;
  bool apiCallingStatus = false;
  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  Future<dynamic> getUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString("user_id");
    lineId = prefs.getInt("line_id_selected") ?? 0;

    print("UserId: $userId");
    print("Saved LineId: $lineId");

    if (userId != null && userId!.isNotEmpty) {
      await getApiCalling();
    }
  }

  Future<void> getApiCalling() async {
    Uri url = Uri.parse(
        "${AppConfigProvider.apiUrl}getAllCollectAmount.php?user_id=$userId&Line=$lineId");

    print("API URL: $url");

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${AppConstant.token}"
    };

    setState(() {
      isAPICalling = true;
    });

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final res = json.decode(response.body);
        print("API Response: $res");

        // await Future.delayed(Duration(seconds: 2), () {});

        if (res['success'].toString() == "true") {
          setState(() {
            prev_remaining_amount = res["prev_remaining_amount"].toString();
            get_total_collect_amt = res["get_total_collect_amt"].toString();
            get_total_adv_collect_amt =
                res["get_total_adv_collect_amt"].toString();
            get_total_billing_amt = res["get_total_billing_amt"].toString();
          });

          List<dynamic> allLines = res['all_lines'] ?? [];
          city.clear();
          city.add(
            {'line_address': "Select Line", "line_id": 0},
          );
          city.addAll(allLines.map((e) => e));
          // selectedCity = city[0];
          selectedCity =
              city.where((element) => lineId == element['line_id']).toList()[0];
          setState(() {});
          setState(() {
            isAPICalling = false;
            isAPICallingShimmer = false;
          });
        } else {
          SnackBarToastMessage.showSnackBar(context, res['msg'][language]);
          setState(() {
            isAPICalling = false;
            isAPICallingShimmer = false;
          });
        }
      } else {
        setState(() {
          isAPICalling = false;
          isAPICallingShimmer = false;
        });
      }
    } catch (e) {
      debugPrint("API Error: $e");
      setState(() {
        isAPICalling = false;
        isAPICallingShimmer = false;
      });
    }
  }

  List<Map<String, dynamic>> city = [
    // "MUNDI",
    {'line_address': "Select Line", "line_id": 0},
    {'line_address': "MUNDI", "line_id": 0},
  ];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
        child: buildUIScreen(context), inAsyncCall: isAPICalling);
  }

  Widget buildUIScreen(BuildContext context) {
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
                  height: MediaQuery.of(context).size.height * 7 / 100,
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
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 7 / 100,
              width: MediaQuery.of(context).size.width * 100 / 100,
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
                            height: MediaQuery.of(context).size.width * 7 / 100,
                            width: MediaQuery.of(context).size.width * 7 / 100,
                            child: Image.asset(AppImage.mainicon),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                // physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: AppColor.secondryColor,
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              width:
                                  MediaQuery.of(context).size.width * 20 / 100,
                              height:
                                  MediaQuery.of(context).size.width * 20 / 100,
                              child: Image.asset(
                                AppImage.cableicon,
                                width: MediaQuery.of(context).size.width *
                                    20 /
                                    100,
                                height: MediaQuery.of(context).size.width *
                                    20 /
                                    100,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                AppLanguage.welcometext[language],
                                style: TextStyle(
                                  fontSize: 25,
                                  color: AppColor.bluecolor,
                                  fontFamily: AppFont.fontFamily2,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                AppLanguage.govind[language],
                                style: TextStyle(
                                  fontFamily: AppFont.fontFamily2,
                                  color: AppColor.bluecolor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 22,
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    1 /
                                    100,
                              ),
                              Text(
                                AppLanguage.selectcity[language],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: AppFont.fontFamily2,
                                  color: AppColor.bluecolor,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 2 / 100,
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 75 / 100,
                            decoration: BoxDecoration(
                              color: AppColor.buttoncolor,
                              border: Border.all(color: AppColor.primaryColor),
                              borderRadius: BorderRadius.circular(1),
                            ),
                            child: DropdownButton(
                              value: selectedCity,
                              isExpanded: true,
                              alignment: Alignment.center,
                              hint: Text(
                                AppLanguage.selectcity[language],
                                textAlign: TextAlign.center,
                              ),
                              underline: const SizedBox(),
                              items: List.generate(
                                  city.length,
                                  (index) => DropdownMenuItem(
                                      value: city[index],
                                      child: Center(
                                          child: Text(
                                              city[index]['line_address'])))),
                              onChanged: (dynamic newValue) async {
                                setState(() {
                                  selectedCity = newValue;
                                  lineId = newValue['line_id'];
                                });

                                // local data Save karna k liye---------
                                final prefs =
                                    await SharedPreferences.getInstance();
                                await prefs.setInt("line_id_selected", lineId);
                                await getApiCalling();
                              },
                            ),
                          ),
                          SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 2 / 100,
                          ),
                          AppButton(
                            text: AppLanguage.submitButtonText[language],
                            onPress: () {
                              getApiCalling();
                            },
                          ),
                          SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 5 / 100,
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 1 / 100),
                          isAPICallingShimmer
                              ? Shimmer.fromColors(
                                  child: Container(
                                    height: 200,
                                    width: MediaQuery.of(context).size.width *
                                        90 /
                                        100,
                                    color: Colors.grey.withOpacity(0.4),
                                  ),
                                  baseColor: Colors.grey,
                                  highlightColor: Colors.black)
                              : Column(
                                  children: [
                                    Text(
                                      AppLanguage.billingamount[language],
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      get_total_billing_amt,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontSize: 21,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      AppLanguage.collectamount[language],
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      get_total_collect_amt,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontSize: 21,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      AppLanguage.remaining[language],
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      get_total_adv_collect_amt,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontSize: 21,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      AppLanguage.previous[language],
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      prev_remaining_amount,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontSize: 21,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
                                height: MediaQuery.of(context).size.height *
                                    1 /
                                    100,
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
                                height: MediaQuery.of(context).size.height *
                                    1 /
                                    100,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width *
                                    60 /
                                    100,
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
                                height: MediaQuery.of(context).size.height *
                                    3 /
                                    100,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width *
                                    82 /
                                    100,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
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

                                        final prefs = await SharedPreferences
                                            .getInstance();

                                        final Mobile =
                                            prefs.getString("mobile");
                                        final password =
                                            prefs.getString("password");
                                        final rememberMe =
                                            prefs.getBool("rememberMe") ??
                                                false;

                                        print("Response --> $Mobile");
                                        print("Response --> $password");
                                        await prefs.setBool(
                                            "isLoggedIn", false);
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Login()),
                                          (Route<dynamic> route) => false,
                                        );
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                30 /
                                                100,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                5 /
                                                100,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: AppColor.themeColor,
                                          borderRadius:
                                              BorderRadius.circular(29),
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
}
