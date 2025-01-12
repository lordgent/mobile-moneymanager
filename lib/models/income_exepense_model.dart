class IncomeOrExpense {
  final String name;
  final String total;

  IncomeOrExpense(
    this.name,
    this.total,
  );

  factory IncomeOrExpense.fromJson(Map<String, dynamic> json) {

    return IncomeOrExpense(
      json['data']?['name']?.toString() ?? '-',
      json['data']?['total']?.toString() ?? '0', 
    );
  }
}
