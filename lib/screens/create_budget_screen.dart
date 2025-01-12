import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:moneymanager/models/categories_model.dart';
import 'package:moneymanager/services/categories/list_category_service.dart';
import 'package:moneymanager/services/transaction/add_income_service.dart';
import 'package:cool_alert/cool_alert.dart';

class CreateBudgetScreen extends StatefulWidget {
  const CreateBudgetScreen({super.key});

  @override
  _CreateBudgetScreenState createState() => _CreateBudgetScreenState();
}

class _CreateBudgetScreenState extends State<CreateBudgetScreen> {
  late Future<List<CategoriesModel>?> categoryList;
  final serviceCategory = CategoriesService();
  CategoriesModel? selectedCategory;
  bool isLoading = false;

  final TextEditingController _amountController = TextEditingController();

  final AddIncomeService addIncomeService = AddIncomeService();

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    categoryList = serviceCategory.fetchCategories("Expense");
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

  Future<void> _onContinue() async {
    setState(() {
      isLoading = true;
    });

    if (_amountController.text.isEmpty || selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      setState(() {
        isLoading = false;
      });
      return;
    }

    String amount = _amountController.text;
    String categoryId = selectedCategory!.id;

    String categoryAction = "Income";

    bool success = true;
    if (success) {
      setState(() {
        isLoading = false;
      });

      CoolAlert.show(
        context: context,
        type: CoolAlertType.success,
        text: "Success",
      );
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, '/home');
      });
    } else {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to add income')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: const Color.fromARGB(255, 123, 73, 241),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: screenHeight * 0.1,
                decoration: const BoxDecoration(
                  color: const Color.fromARGB(255, 123, 73, 241),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 40),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(context, "/home");
                            },
                            child: Icon(
                              color: Colors.white,
                              Icons.arrow_back,
                              size: screenWidth * 0.08,
                            ),
                          ),
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
                padding: const EdgeInsets.all(12),
                child: const Text(
                  "How much do yo want to spend?",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontSize: 24,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(15),
                    rupiahFormatter(),
                  ],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                  ),
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 32,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              Container(
                height: screenHeight * 0.6,
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FutureBuilder<List<CategoriesModel>?>(
                            future: categoryList,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              }

                              if (snapshot.hasError) {
                                return Text("Error: ${snapshot.error}");
                              }

                              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                return const Text("No categories available.");
                              }

                              return Container(
                                width: double.infinity,
                                child: DropdownButton<CategoriesModel>(
                                  hint: Text(
                                    "Category",
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  onChanged: (CategoriesModel? newValue) {
                                    setState(() {
                                      selectedCategory = newValue;
                                    });
                                  },
                                  isExpanded: true,
                                  value: selectedCategory,
                                  items: snapshot.data!
                                      .map<DropdownMenuItem<CategoriesModel>>(
                                    (CategoriesModel category) {
                                      return DropdownMenuItem<CategoriesModel>(
                                        value: category,
                                        child: Text(category.name),
                                      );
                                    },
                                  ).toList(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 123, 73, 241),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        onPressed: isLoading ? () {} : _onContinue,
                        child: isLoading
                            ? const CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              )
                            : const Text('Continue',
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
    );
  }
}
