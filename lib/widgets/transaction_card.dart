import 'package:flutter/material.dart';
import 'package:moneymanager/models/transaction_model.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TransactionCard extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionCard({Key? key, required this.transaction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Container(
        child: Row(
          children: [
            // Icon Section
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 241, 194, 93),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0), // Padding for the icon
                child: Icon(
              Icons.category,
              color: Color.fromARGB(255, 247, 247, 247),
              size: 28,
            ),
              ),
            ),
            const SizedBox(width: 10), // Add some space between the icon and text

            // Text and Category Section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        transaction.category?.name ?? "No category",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.purple,
                        ),
                      ),
                      Text(
                        '- Rp${NumberFormat("#,##0", "id_ID").format(double.parse(transaction.total))}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color:  Color.fromARGB(255, 255, 75, 52),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5), // Space between rows
                  // Transaction Title
                  Text(
                    transaction.title ?? "Untitled",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
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
