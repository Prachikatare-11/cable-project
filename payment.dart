import 'package:cableproject/utilities/app_color.dart';
import 'package:cableproject/utilities/app_constant.dart';
import 'package:cableproject/utilities/app_font.dart';
import 'package:cableproject/utilities/app_image.dart';
import 'package:cableproject/utilities/app_language.dart';
import 'package:cableproject/view/authentication/Home.dart';
import 'package:cableproject/view/authentication/paymenthistory.dart';
import 'package:flutter/material.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  int selectedIndex = 0;
  List<Map<String, dynamic>> payment = [
    {"Month": "Sep 2025", "Due": "-300", "pay Amt": "300"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: MediaQuery.of(context).size.height * 7 / 100,
            width: MediaQuery.of(context).size.width,
            color: AppColor.redColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Home(),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    width: MediaQuery.of(context).size.width * 7 / 100,
                    child: Image.asset(AppImage.iconbutton),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = 0;
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * 7 / 100,
                  width: MediaQuery.of(context).size.width * 50 / 100,
                  color: selectedIndex == 0 ? Colors.white : AppColor.redColor,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Payment(),
                        ),
                      );
                    },
                    child: Text(
                      AppLanguage.currentpay[language],
                      style: TextStyle(
                        color: selectedIndex == 0
                            ? AppColor.redColor
                            : Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = 1;
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * 7 / 100,
                  width: MediaQuery.of(context).size.width * 50 / 100,
                  color: selectedIndex == 1 ? Colors.white : AppColor.redColor,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Paymenthistory(
                            userId: '',
                            customerId: '',
                            connectionId: '',
                          ),
                        ),
                      );
                    },
                    child: Text(
                      AppLanguage.previouspay[language],
                      style: TextStyle(
                        color: selectedIndex == 1
                            ? AppColor.redColor
                            : Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 2 / 100),
          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 100 / 100,
                height: MediaQuery.of(context).size.height * 10 / 100,
                color: AppColor.secondryColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 22 / 100,
                      child: Text(
                        "Month",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 22 / 100,
                      child: Text(
                        "Due",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 22 / 100,
                      child: Text(
                        "pay Amt",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 22 / 100,
                      child: Text(
                        "Action",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              ...payment.map((item) {
                return Container(
                  // width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 6 / 100,
                  color: Colors.grey.shade200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 22 / 100,
                        child: Text(
                          item["Month"],
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 22 / 100,
                        child: Text(
                          item["Due"],
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 22 / 100,
                        child: Text(
                          item["pay Amt"],
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 22 / 100,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              AppLanguage.pay[language],
                              style: TextStyle(
                                color: AppColor.redColor,
                                fontFamily: AppFont.fontFamily,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ))
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ]),
      ),
    ));
    //   ),
    // );
  }
}
