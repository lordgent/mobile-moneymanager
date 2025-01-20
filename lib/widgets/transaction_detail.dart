import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:moneymanager/models/payment_detail_model.dart';
import 'package:moneymanager/services/payment/payment_detail_service.dart';

class TransactionDetail extends StatefulWidget {
  const TransactionDetail({super.key});

  @override
  State<TransactionDetail> createState() => _TransactionDetailState();
}

class _TransactionDetailState extends State<TransactionDetail> {
  PaymentData? data;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  final PaymentDetailService service = PaymentDetailService();
  @override
  void initState() {
    super.initState();
    _fetchPaymentDetail();
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

  Future<void> _fetchPaymentDetail() async {
    try {
      PaymentData? response = await service.fetchPaymentDetailInfo();

      setState(() {
        data = response;
      });
    } catch (error) {
      print("Error fetching payment details: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Pembayaran'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () async {
            await _secureStorage.write(key: 'selectedIndex', value: "0");
            Navigator.pushReplacementNamed(context, '/home');
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                Center(
                  child: Text(
                    data?.createdAt.toString() ?? '-',
                    style: TextStyle(fontSize: 23),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Layanan",
                      style: TextStyle(fontSize: 17),
                    ),
                    Text(
                      "--",
                      style: TextStyle(fontSize: 17),
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.network(
                      width: 45,
                      height: 45,
                      'https://storage-webapps.s3.ap-southeast-3.amazonaws.com/' +
                          (data?.payment?.icon ?? "-"),
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      (loadingProgress.expectedTotalBytes ?? 1)
                                  : null,
                            ),
                          );
                        }
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Center(child: Text('-'));
                      },
                    ),
                    Row(
                      children: [
                        Text(
                          data?.payment?.name ?? '-',
                          style: TextStyle(fontSize: 17),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Copy",
                      style: TextStyle(fontSize: 17),
                    ),
                    Text(
                      data?.numberCode ?? "-",
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Status",
                      style: TextStyle(fontSize: 17),
                    ),
                    Center(
                      child: Container(
                        padding: EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 255, 249, 230),
                        ),
                        child: Text(
                          data?.status ?? "-",
                          style: TextStyle(fontSize: 15, color: Colors.amber),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Biaya Admin",
                      style: TextStyle(fontSize: 17),
                    ),
                    Text(
                      formatRupiah(data?.adminFee ?? "0"),
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Biaya",
                      style: TextStyle(fontSize: 17),
                    ),
                    Text(
                      formatRupiah(data?.amount ?? "0"),
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Pembayaran",
                      style: TextStyle(fontSize: 17),
                    ),
                    Text(
                      formatRupiah(data?.total ?? "0"),
                      style: TextStyle(
                        fontSize: 19,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
