import 'package:flutter/material.dart';
import 'package:moneymanager/models/subscription_model.dart';
import 'package:moneymanager/services/subscription/subscription_list.dart';
import 'package:intl/intl.dart';

class StatusPayment extends StatefulWidget {
  const StatusPayment({super.key});

  @override
  State<StatusPayment> createState() => _StatusPaymentState();
}

class _StatusPaymentState extends State<StatusPayment> {
  late Future<List<SubscriptionModel>?> subscriptions;
  final subService = SubscriptionListService();
  SubscriptionModel? selectedSubscription;

  @override
  void initState() {
    super.initState();
    _fetchSubscriptions();
  }

  Future<void> _fetchSubscriptions() async {
    subscriptions = subService.fetchListSubscription();
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
    return Container(
      padding: const EdgeInsets.all(10.0),
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            children: [
              SizedBox(
                height: 20,
              ),
              const Text(
                'Pilih Paket Langganan Anda',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 20),
              FutureBuilder<List<SubscriptionModel>?>(
                future: subscriptions,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text('No subscriptions available');
                  } else {
                    var subscriptionList = snapshot.data!;

                    return Column(
                      children: subscriptionList.map((subscription) {
                        bool isSelected = selectedSubscription == subscription;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedSubscription =
                                  isSelected ? null : subscription;
                            });
                          },
                          child: Container(
                            color: isSelected
                                ? Color.fromARGB(255, 251, 242, 216)
                                : Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.payment_rounded,
                                    size: 40,
                                    color: Color.fromARGB(255, 149, 33, 243),
                                  ),
                                  const SizedBox(width: 20),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        subscription.name,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        subscription.description,
                                        style: const TextStyle(
                                          color: Colors.black54,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'Rp ' +
                                            formatRupiah(subscription.amount) +
                                            '/bulan',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  }
                },
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              if (selectedSubscription != null) {
                Navigator.pushNamed(
                  context,
                  '/nextPayment',
                  arguments: {
                    'name': selectedSubscription?.name ?? 'Unknown',
                    'amount': selectedSubscription?.amount ?? 'Unknown',
                    'id': selectedSubscription?.id ?? 'Unknown',
                  },
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please select a subscription')),
                );
              }
            },
            child: Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text(
                  "Lanjutkan Pembayaran",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
