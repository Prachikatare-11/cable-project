import 'dart:convert';
import 'package:cableproject/utilities/app_color.dart';
import 'package:cableproject/utilities/app_config_provider.dart';
import 'package:cableproject/utilities/app_constant.dart';
import 'package:cableproject/utilities/app_image.dart';
import 'package:cableproject/utilities/app_language.dart';
import 'package:cableproject/view/authentication/Home.dart';
import 'package:cableproject/view/authentication/payment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart'; 

class Paymenthistory extends StatefulWidget {
  final String customerId;
  final String connectionId;
  final String userId;

  const Paymenthistory({
    super.key,
    required this.customerId,
    required this.connectionId,
    required this.userId,
  });

  @override
  State<Paymenthistory> createState() => _PaymenthistoryState();
}

class _PaymenthistoryState extends State<Paymenthistory> {
  List<Map<String, dynamic>> allPayments = [];
  bool isLoading = true;
  String currentDue = "NA";

  int selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    fetchPaymentHistory();
  }

  Future<void> fetchPaymentHistory() async {
    try {
      final response = await http.post(
        Uri.parse("${AppConfigProvider.apiUrl}getCustomerDetail.php"),
        body: {
          "user_id": widget.userId,
          "customer_id": widget.customerId,
          "connection_id": widget.connectionId,
        },
      );

      print("Response: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          currentDue = data["current_due"]?.toString() ?? "NA";
          allPayments =
              List<Map<String, dynamic>>.from(data["previous_arr"] ?? []);
          isLoading = false;
        });
      } else {
        setState(() => isLoading = false);
      }
    } catch (e) {
      print("Error: $e");
      setState(() => isLoading = false);
    }
  }

  Future<void> _openInvoice(String url) async {
    if (url.isNotEmpty && await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Unable to open invoice")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
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
                        MaterialPageRoute(builder: (context) => const Home()),
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
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() => selectedIndex = 0);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Payment()),
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height * 7 / 100,
                      color:
                          selectedIndex == 0 ? Colors.white : AppColor.redColor,
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
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() => selectedIndex = 1);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height * 7 / 100,
                      color:
                          selectedIndex == 1 ? Colors.white : AppColor.redColor,
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

            const SizedBox(height: 10),

            /// 🔹 Current Due (if available)
            Container(
              padding: const EdgeInsets.all(12),
              width: double.infinity,
              color: Colors.orange.shade100,
              child: Text(
                "Current Due: $currentDue",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),

            const SizedBox(height: 10),

            /// 🔹 Payment List
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : allPayments.isEmpty
                      ? const Center(child: Text("No Payment History Found"))
                      : Column(
                          children: [
                            Container(
                              height: 50,
                              color: AppColor.secondryColor,
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text("Date",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Expanded(
                                    child: Text("Amount",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Expanded(
                                    child: Text("Invoice",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: allPayments.length,
                                itemBuilder: (context, index) {
                                  final item = allPayments[index];
                                  final date = item["date"] ?? "";
                                  final amount = item["amount"] ?? "";
                                  final invoiceUrl =
                                      item["new_payment_id"] ?? "";

                                  return Container(
                                    height: 50,
                                    color: index.isEven
                                        ? Colors.grey.shade200
                                        : Colors.white,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(date,
                                              textAlign: TextAlign.center),
                                        ),
                                        Expanded(
                                          child: Text(amount,
                                              textAlign: TextAlign.center),
                                        ),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () =>
                                                _openInvoice(invoiceUrl),
                                            child: const Icon(Icons.receipt,
                                                color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
