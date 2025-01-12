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
      margin: EdgeInsets.only(bottom: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Container(
        
            child:  Container(
              child: Image.network(
            width: 45,
            height: 45,
            'https://storage-webapps.s3.ap-southeast-3.amazonaws.com/'+ transaction.category.icon,
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
            ),
          ),
          const SizedBox(width: 10), 
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
                        color: Color.fromARGB(255, 149, 33, 243),
                      ),
                    ),
                    Text(
                      transaction.typeAction == "Expense" ? "- Rp${NumberFormat("#,##0", "id_ID").format(double.parse(transaction.total))} " : "Rp${NumberFormat("#,##0", "id_ID").format(double.parse(transaction.total))}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: transaction.typeAction == 'Expense'? const Color.fromARGB(221, 240, 59, 59) : Color.fromARGB(221, 54, 232, 107),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5), 
                Text(
                  transaction.title ?? "Untitled",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
