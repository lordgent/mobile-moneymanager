import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneymanager/models/PaymentResponse.dart';
import 'package:moneymanager/models/create_payment_response.dart';
import 'package:moneymanager/services/payment/list_payment_method.dart';
import 'package:moneymanager/services/subscription/create_subscription.dart';
import 'package:moneymanager/screens/web_view.dart';

class NextPayment extends StatefulWidget {
  const NextPayment({super.key});

  @override
  State<NextPayment> createState() => _NextPaymentState();
}

class _NextPaymentState extends State<NextPayment> {
  late Map<String, String> args;
  int? selectedAccountIndex;
  String? codeVa;
  final subscriptionCreateService = SubscriptionCreateService();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>?;

    if (routeArgs != null) {
      args = routeArgs;
    } else {
      args = {'name': 'Unknown', 'amount': 'Unknown', 'id': 'Unknown'};
    }
  }

  late Future<PaymentMethodsResponse?> payments;
  final servicePay = PaymentMethodService();

  @override
  void initState() {
    super.initState();
    _fetchListPayment();
  }

  Future<void> _fetchListPayment() async {
    payments = servicePay.fetchListPayment();
    setState(() {});
  }

  String formatRupiah(String amount) {
    final number = int.tryParse(amount.replaceAll(',', ''));
    if (number == null) {
      return '';
    }
    final format =
        NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0);
    return format.format(number);
  }

  @override
  Widget build(BuildContext context) {
    String subscriptionName = args['name'] ?? 'Unknown';
    String subscriptionAmount = args['amount'] ?? 'Unknown';
    String subscriptionId = args['id'] ?? 'Unknown';
    int total = int.parse(subscriptionAmount) + 6500;

    Future<CreatePaymentResponse?> _handlePayment() async {
      print("$codeVa");
      CreatePaymentResponse? success = await subscriptionCreateService
          .createSubscription(subscriptionId, codeVa ?? "");

      if (success != null && success.url != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WebViewPage(),
            settings: RouteSettings(arguments: success.url),
          ),
        );
        print(success.url);
        return success;
      } else {
        print('Payment creation failed.');
        return null;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Pilih Metode Pembayaran'),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "ATM/Bank Transfer",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                FutureBuilder<PaymentMethodsResponse?>(
                  future: payments,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    if (!snapshot.hasData ||
                        snapshot.data?.virtualAccount.isEmpty == true) {
                      return Center(
                          child: Text('No payment methods available'));
                    }

                    var paymentMethods = snapshot.data?.virtualAccount;

                    return Column(
                      children: paymentMethods!.map((virtualAccount) {
                        int index = paymentMethods.indexOf(virtualAccount);
                        bool isSelected = selectedAccountIndex == index;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedAccountIndex = isSelected ? null : index;
                              codeVa = virtualAccount.code;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Color.fromARGB(255, 255, 249, 231)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 4,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                // Icon
                                Image.network(
                                  'https://storage-webapps.s3.ap-southeast-3.amazonaws.com/${virtualAccount.icon}',
                                  width: 50,
                                  height: 50,
                                ),
                                const SizedBox(width: 20),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      virtualAccount.name,
                                      style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "E-Wallet",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text("Belum Tersedia"),
                )
              ],
            ),
            SizedBox(height: 20),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Langganan",
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      '$subscriptionName',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      "Rp " + formatRupiah(subscriptionAmount),
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Biaya Admin",
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      "Rp " + formatRupiah('6500'),
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Pembayaran",
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      "Rp " + formatRupiah(total.toString()),
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                )
              ],
            ),
            // Payment Button
            GestureDetector(
              onTap: () {
                if (selectedAccountIndex != null) {
                  _handlePayment();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Please select a payment method'),
                  ));
                }
              },
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    "Bayar",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
