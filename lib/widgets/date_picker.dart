import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerWidget extends StatefulWidget {
  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = _selectedDate == null
        ? 'No date selected!'
        : DateFormat('dd-MM-yyyy').format(_selectedDate!);

    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () => _selectDate(context),
          child: Text(
            formattedDate,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }
}
