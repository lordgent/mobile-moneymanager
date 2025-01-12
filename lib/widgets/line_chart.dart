import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:moneymanager/models/chart_income_expense.dart';
import 'package:moneymanager/services/transaction/chart_stick.dart';
import 'package:intl/intl.dart'; // Import intl package

class TransactionChart extends StatefulWidget {
  @override
  _TransactionChartState createState() => _TransactionChartState();
}

class _TransactionChartState extends State<TransactionChart> {
  late Future<List<ChartIncomeOrExpense>?> chartStick;

  @override
  void initState() {
    super.initState();
    chartStick = fetchChartStick();
  }

  Future<List<ChartIncomeOrExpense>?> fetchChartStick() async {
    return await ChartStickExpenseOrIncome().fetchChartStickExpenseOrIncome(
        startDate: "",
        endDate: "",
        actionName: "13592003-b611-4312-b3d6-746da6c9de58");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ChartIncomeOrExpense>?>(
      future: chartStick,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No data available'));
        } else {
          List<ChartIncomeOrExpense> data = snapshot.data!;

          double maxHeight = 100000;
          double highestValue = data
              .map((e) => double.tryParse(e.total) ?? 0.0)
              .reduce((a, b) => a > b ? a : b);
          if (highestValue > maxHeight) {
            maxHeight = highestValue;
          }

          return Padding(
            padding: const EdgeInsets.all(6.0),
            child: SizedBox(
              height: 200,
              width: double.infinity,
              child: BarChart(
                BarChartData(
                  maxY: maxHeight, // Menetapkan tinggi maksimum sumbu Y
                  gridData: FlGridData(
                    show: false, // Menonaktifkan grid
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Colors.grey.withOpacity(0.3),
                        strokeWidth: 1,
                      );
                    },
                    getDrawingVerticalLine: (value) {
                      return FlLine(
                        color: Colors.grey.withOpacity(0.3),
                        strokeWidth: 1,
                      );
                    },
                  ),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: false,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: false,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: false, // Menonaktifkan border
                  ),
                  barGroups: List.generate(data.length, (index) {
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: double.tryParse(data[index].total) ?? 0.0,
                          color: Color.fromARGB(255, 149, 33, 243),
                          width: 18,
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
