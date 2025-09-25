import 'dart:convert';
import 'package:cableproject/utilities/app_color.dart';
import 'package:cableproject/utilities/app_config_provider.dart';
import 'package:cableproject/utilities/app_constant.dart';
import 'package:cableproject/utilities/app_font.dart';
import 'package:cableproject/utilities/app_image.dart';
import 'package:cableproject/utilities/app_language.dart';
import 'package:cableproject/view/authentication/Home.dart';
import 'package:cableproject/view/authentication/login.dart';
import 'package:cableproject/view/authentication/payment.dart';
import 'package:cableproject/view/authentication/paymenthistory.dart';
import 'package:cableproject/view/authentication/searchcustomer.dart';
import 'package:cableproject/view/authentication/viewallcustomers.dart';
import 'package:cableproject/view/authentication/viewpaid.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ViewUnpaidCustomer extends StatefulWidget {
  static String routeName = '/viewUnpaidCustomer';

  @override
  State<ViewUnpaidCustomer> createState() => _ViewUnpaidCustomerState();
}

class _ViewUnpaidCustomerState extends State<ViewUnpaidCustomer> {
  final ScrollController _scrollController = ScrollController();
  String? userId = "";
  int lineId = 0;

  bool isLoading = true;
  bool _loadingMore = false;

  final int _perPage = 20;
  int _currentCount = 20;

  List<Map<String, dynamic>> allCustomers = [];
  List<Map<String, dynamic>> filteredCustomers = [];

  @override
  void initState() {
    super.initState();
    getUserDetails();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_loadingMore &&
        _currentCount < filteredCustomers.length) {
      setState(() {
        _loadingMore = true;
      });

      Future.delayed(const Duration(milliseconds: 200), () {
        setState(() {
          _currentCount += _perPage;
          if (_currentCount > filteredCustomers.length) {
            _currentCount = filteredCustomers.length;
          }
          _loadingMore = false;
        });
      });
    }
  }

  Future<void> getUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString("user_id");
    lineId = prefs.getInt("line_id_selected") ?? 0;
    if (mounted && userId != null && userId!.isNotEmpty) {
      await _fetchAllData();
    }
  }

  Future<void> _fetchAllData() async {
    setState(() => isLoading = true);
    Uri url = Uri.parse(
        "${AppConfigProvider.apiUrl}getalldata_new2023.php?user_id=$userId&line_id=$lineId");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final res = json.decode(response.body);

        if (res['success'].toString() == "true") {
          List<dynamic> allLines = res['unpaid_arr'] ?? [];

          allCustomers = allLines
              .map((e) => {
                    "id": e["customer_id"].toString(),
                    "setupBox": e["setup_box_no"].toString(),
                    "name": "${e["fname"]} ${e["lname"]}",
                    "date": e["connection_date"].toString(),
                    "house": e["building_name"].toString(),
                    "area": e["area"].toString(),
                    "road": e["address"].toString(),
                    "phone": e["mobile"].toString(),
                    "rate": e["rate_amount"].toString(),
                    "deposit": e["due_amount"].toString(),
                    "status": e["due_amount"] == 0 ? "true" : "false",
                  })
              .toList();

          filteredCustomers = List.from(allCustomers);
          _currentCount = _perPage;
        }
      }
    } catch (e) {
      debugPrint("API Error: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _resetCount() {
    setState(() {
      _currentCount = _perPage;
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Map<String, dynamic>> get displayedCustomers =>
      filteredCustomers.take(_currentCount).toList();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColor.primaryColor,
      statusBarIconBrightness: Brightness.light,
    ));

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
            SizedBox(height: MediaQuery.of(context).size.height * 3 / 100),
            Text(
              AppLanguage.aLL[language],
              style: TextStyle(
                fontSize: 20,
                color: AppColor.bgColor,
                fontFamily: AppFont.fontFamily2,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 2 / 100),
            SizedBox(
              width: MediaQuery.of(context).size.width * 90 / 100,
              height: MediaQuery.of(context).size.height * 6 / 100,
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    filteredCustomers = allCustomers
                        .where((customer) => customer['name']
                            .toLowerCase()
                            .contains(value.toLowerCase()))
                        .toList();
                    _resetCount();
                  });
                },
                decoration: InputDecoration(
                  hintText: AppLanguage.search2[language],
                  hintStyle: TextStyle(
                    color: AppColor.h1,
                    fontFamily: AppFont.fontFamily2,
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
            Expanded(
              child: isLoading && allCustomers.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : RefreshIndicator(
                      onRefresh: () async {
                        await _fetchAllData();
                      },
                      child: ListView.builder(
                        controller: _scrollController,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: displayedCustomers.length + 1,
                        itemBuilder: (context, index) {
                          if (index < displayedCustomers.length) {
                            final customer = displayedCustomers[index];
                            return _buildCustomerCard(customer, context);
                          } else {
                            return (_currentCount < filteredCustomers.length)
                                ? const Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Center(
                                        child: CircularProgressIndicator()),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Center(
                                        child: Text(
                                            AppLanguage.noloadmore[language])),
                                  );
                          }
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomerCard(Map<String, dynamic> customer, BuildContext ctx) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
              color: AppColor.primaryColor.withOpacity(0.3),
              blurRadius: 4,
              offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          infoRow("ID", customer['id']),
          infoRow("Name", customer['name']),
          infoRow("Setup Box", customer['setupBox']),
          infoRow("Phone", customer['phone']),
          infoRow("Date", customer['date']),
          infoRow("House", customer['house']),
          infoRow("Area", customer['area']),
          infoRow("Road", customer['road']),
          infoRow("Rate", "₹${customer['rate']}"),
          infoRow("Deposit", customer['deposit'],
              isNegative: customer['deposit'].toString().contains("-")),
          infoRow(
              "Status",
              customer['status'].toString().toLowerCase() == "true"
                  ? "Paid"
                  : "Unpaid",
              isNegative:
                  customer['status'].toString().toLowerCase() != "true"),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(
                AppLanguage.unpaidtext[language],
                style: const TextStyle(
                  decoration: TextDecoration.underline,
                  color: AppColor.bgColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Paymenthistory(userId: '', customerId: '', connectionId: '',),
                  ),
                );
                },
                child: Image.asset(AppImage.arrowicon2,
                    height: MediaQuery.of(context).size.height * 4 / 100),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget infoRow(String label, String value, {bool isNegative = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey, width: 1),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(label,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 14)),
            ),
            Expanded(
              child: Text(
                value,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: isNegative ? Colors.red : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
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
                    ],
                  ),
                ],
              ),
            ),
          );
        });
      });
}
