import 'dart:convert';
import 'package:cableproject/utilities/app_color.dart';
import 'package:cableproject/utilities/app_constant.dart';
import 'package:cableproject/utilities/app_image.dart';
import 'package:cableproject/utilities/app_language.dart';
import 'package:cableproject/view/authentication/Home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Paymenthistory extends StatefulWidget {
  final String userId;
  final String customerId;
  final String connectionId;

  const Paymenthistory({
    super.key,
    required this.userId,
    required this.customerId,
    required this.connectionId,
  });

  @override
  State<Paymenthistory> createState() => _PaymenthistoryState();
}

class _PaymenthistoryState extends State<Paymenthistory> {
  List<Map<String, dynamic>> allCustomers = [];
  int selectedIndex = 1;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchPaymentHistory();
  }

  Future<void> fetchPaymentHistory() async {
    final url =
        "https://sairamcable.in/cb_cable/newapp_api/getCustomerDetail.php?user_id=${widget.userId}&customer_id=${widget.customerId}&connection_id=${widget.connectionId}";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data["success"] == true) {
        List history = data["previous_arr"];
        setState(() {
          allCustomers = history.map<Map<String, dynamic>>((item) {
            return {
              "date": item["date"],
              "amount": item["amount"],
              "payment_id": item["payment_id"],
              "invoice": item["new_payment_id"],
            };
          }).toList();
          loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: loading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(children: [
                  NoInternetBanner(),
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
                      Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height * 7 / 100,
                        width: MediaQuery.of(context).size.width * 50 / 100,
                        color: AppColor.redColor,
                        child: Text(
                          AppLanguage.currentpay[language],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height * 7 / 100,
                        width: MediaQuery.of(context).size.width * 50 / 100,
                        color: Colors.white,
                        child: Text(
                          AppLanguage.previouspay[language],
                          style: TextStyle(
                            color: AppColor.redColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 2 / 100),
                  Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 7 / 100,
                        color: AppColor.secondryColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            SizedBox(
                              width: 120,
                              child: Text(
                                "Date",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              width: 120,
                              child: Text(
                                "Amount",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              width: 120,
                              child: Text(
                                "Action",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ...allCustomers.map((item) {
                        return Container(
                          height: MediaQuery.of(context).size.height * 6 / 100,
                          color: Colors.grey.shade200,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 120,
                                child: Text(
                                  item["date"] ?? "-",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                width: 120,
                                child: Text(
                                  item["amount"] ?? "-",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                width: 120,
                                child: IconButton(
                                  icon: const Icon(Icons.share,
                                      color: Colors.red),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PaymentDetailPage(data: item),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ]),
              ),
      ),
    );
  }
}

class PaymentDetailPage extends StatelessWidget {
  final Map<String, dynamic> data;
  const PaymentDetailPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Payment Detail")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Date: ${data["date"]}"),
            Text("Amount: ${data["amount"]}"),
            Text("Payment ID: ${data["payment_id"]}"),
            Text("Invoice No: ${data["invoice"]}"),
          ],
        ),
      ),
    );
  }
}
