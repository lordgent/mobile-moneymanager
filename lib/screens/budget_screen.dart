import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:moneymanager/models/categories_model.dart';
import 'package:moneymanager/services/categories/list_category_service.dart';
import 'package:moneymanager/widgets/bottom_tab.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  _BudgetScreenState createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  String? _fileName;

  @override
  void initState() {
    super.initState();
  }

 
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _fileName = result.files.single.name;
      });
    }
  }

  final TextEditingController _amountController = TextEditingController();

  String formatRupiah(String amount) {
    final number = int.tryParse(amount.replaceAll(',', ''));
    if (number == null) {
      return '';
    }
    final format =
        NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0);
    return format.format(number);
  }

  TextInputFormatter rupiahFormatter() {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      String newText = newValue.text;
      if (newText.isEmpty) {
        return TextEditingValue(text: '');
      }

      newText = newText.replaceAll(RegExp(r'[^0-9]'), '');
      newText = formatRupiah(newText);
      return TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(color: const Color.fromARGB(255, 149, 33, 243)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: screenHeight * 0.2,
                decoration: const BoxDecoration(
                  color: const Color.fromARGB(255, 149, 33, 243),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                child: Column(
                  children: [
                   const SizedBox(height: 50),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                                                  SizedBox(width: screenWidth * 0.08),
                          const Text(
                            "Budget",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.08),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
          
              Container(
                height: screenHeight * 0.68,
                padding: const EdgeInsets.all(12),
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: screenHeight * 0.4,
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                                                      
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 149, 33, 243),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text('Create a budget',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomTab(),
    );
  }
}
