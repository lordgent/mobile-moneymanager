import 'package:flutter/material.dart';

class StatusPayment extends StatefulWidget {
  const StatusPayment({super.key});

  @override
  State<StatusPayment> createState() => _StatusPaymentState();
}

class _StatusPaymentState extends State<StatusPayment> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            children: [
              const Text(
                'Pilih Paket Langganan Anda',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  color: Colors.white,
                  child: const Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.payment_rounded,
                          size: 40,
                          color: Color.fromARGB(255, 149, 33, 243),
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Paket Dasar',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Fitur dasar untuk mengelola uang Anda.',
                              style: TextStyle(
                                color: Colors.black54,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Rp 49.000/bulan',
                              style: TextStyle(
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
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {},
                child: Container(
                  color: Colors.white,
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.payment_rounded,
                          size: 40,
                          color: Color.fromARGB(255, 149, 33, 243),
                        ),
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Paket Premium',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Akses penuh untuk semua fitur premium.',
                              style: TextStyle(
                                color: Colors.black54,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Rp 99.000/bulan',
                              style: TextStyle(
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
              )
            ],
          ),
          GestureDetector(
            onTap: () => {},
            child: Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.amber, // Background color
                borderRadius:
                    BorderRadius.circular(8), // Menambahkan border radius 8
              ),
              child: const Center(
                child: Text(
                  "Lanjutkan Pembayaran",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white // Optional, to make text bold
                      ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
