import 'package:intl/intl.dart';

class DateRange {
  final DateTime startDate;
  final DateTime endDate;

  DateRange({required this.startDate, required this.endDate});

  String getFormattedStartDate() => DateFormat('yyyy-dd-MM').format(startDate);
  String getFormattedEndDate() => DateFormat('yyyy-dd-MM').format(endDate);
}

DateRange getDateRange(String period) {
  DateTime today = DateTime.now();
  DateTime startDate;

  if (period == 'month') {
    startDate = DateTime(today.year, today.month - 1, today.day);
  } else if (period == 'week') {
    startDate = today.subtract(Duration(days: 7));
  } else if (period == 'year') {
    startDate = DateTime(today.year - 1, today.month, today.day);
  } else {
    throw ArgumentError(
        'Invalid period. Only "month", "week", or "year" are allowed.');
  }

  return DateRange(startDate: startDate, endDate: today);
}
