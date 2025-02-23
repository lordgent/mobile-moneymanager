import 'package:intl/intl.dart';

class DateHelper {
  static Map<String, String> getDateRange(String type) {
    DateFormat dateFormat = DateFormat('ddMMyyyy');
    DateTime now = DateTime.now();
    String startDate, endDate;

    if (type == "now") {
      startDate = dateFormat.format(now);
      endDate = dateFormat.format(now);
    } else if (type == "week") {
      DateTime startOfWeek = now.subtract(Duration(days: 7));
      startDate = dateFormat.format(startOfWeek);
      endDate = dateFormat.format(now);
    } else if (type == "month") {
      DateTime startOfMonth = DateTime(now.year, now.month - 1, now.day);
      startDate = dateFormat.format(startOfMonth);
      endDate = dateFormat.format(now);
    } else if (type == "yesterday") {
      DateTime yesterday = now.subtract(Duration(days: 1));
      startDate = dateFormat.format(yesterday);
      endDate = dateFormat.format(yesterday);
    } else {
      throw ArgumentError("Invalid date range type: $type");
    }

    return {
      "startDate": startDate,
      "endDate": endDate,
    };
  }
}
