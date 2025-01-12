class ChartIncomeOrExpense {
  final String label;
  final String total;

  ChartIncomeOrExpense({required this.label, required this.total});

  // Konversi dari JSON
  factory ChartIncomeOrExpense.fromJson(Map<String, dynamic> json) {
    return ChartIncomeOrExpense(
      label: json['label'],
      total: json['total'].toString(),
    );
  }
}
