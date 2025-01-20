import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:moneymanager/models/categories_model.dart';
import 'package:moneymanager/services/categories/list_category_service.dart';
import 'package:moneymanager/services/transaction/add_income_service.dart';
import 'package:cool_alert/cool_alert.dart';

class AddIncomeScreen extends StatefulWidget {
  const AddIncomeScreen({super.key});

  @override
  _AddIncomeScreenState createState() => _AddIncomeScreenState();
}

class _AddIncomeScreenState extends State<AddIncomeScreen> {
  String? _fileName;
  late Future<List<CategoriesModel>?> categoryList;
  final serviceCategory = CategoriesService();
  CategoriesModel? selectedCategory;
  File? _imageFile;
  bool isLoading = false;

  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final AddIncomeService addIncomeService = AddIncomeService();

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    categoryList = serviceCategory.fetchCategories("Income");
    setState(() {});
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _fileName = result.files.single.name;
        _imageFile = File(result.files.single.path!);
      });
    }
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

    if (_amountController.text.isEmpty ||
        selectedCategory == null ||
        _titleController.text.isEmpty ||
        _descriptionController.text.isEmpty) {
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
    String title = _titleController.text;
    String description = _descriptionController.text;
    String image = _imageFile != null && _imageFile!.path.isNotEmpty
        ? _imageFile!.path
        : '';

    bool success = await addIncomeService.AddIncome(
      amount,
      categoryId,
      image,
      title,
      description,
      "94985fc2-195f-478f-a182-7dd6a7754ea7",
    );

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
          decoration: const BoxDecoration(color: Color(0xFF00A86B)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: screenHeight * 0.2,
                decoration: const BoxDecoration(
                  color: Color(0xFF00A86B),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 50),
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
                            "Income",
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
                  "How much?",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontSize: 32,
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 30,
                            child: TextField(
                              controller: _titleController,
                              decoration: InputDecoration(
                                labelText: 'Title',
                                border: InputBorder.none,
                                labelStyle:
                                    TextStyle(fontSize: screenWidth * 0.05),
                              ),
                            ),
                          ),
                          SizedBox(
                              height: 30,
                              child: TextField(
                                controller: _descriptionController,
                                decoration: InputDecoration(
                                  labelText: 'Description',
                                  border: InputBorder.none,
                                  fillColor:
                                      const Color.fromARGB(255, 210, 210, 210),
                                  labelStyle:
                                      TextStyle(fontSize: screenWidth * 0.05),
                                ),
                              )),
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
                                        fontSize: screenWidth * 0.05,
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
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                onTap: _pickFile,
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Attachment",
                                        style: TextStyle(
                                            fontSize: screenWidth * 0.05,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      const Icon(
                                        Icons.attachment,
                                        color:
                                            Color.fromARGB(255, 206, 206, 206),
                                        size: 30,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              if (_fileName != null)
                                Text(
                                  'Picked file: $_fileName',
                                  style: TextStyle(fontSize: 16),
                                ),
                            ],
                          )
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
