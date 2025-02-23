import 'package:get/get.dart';
import 'package:moneymanager/models/income_exepense_model.dart';
import 'package:moneymanager/services/transaction/total_income_expense_service.dart';

class IncomeExpenseController extends GetxController {
  var incomeOrExpenseData = RxMap<String, IncomeOrExpense?>({
    "Income": null,
    "Expense": null,
  });

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<void> fetchData({
    required String actionName,
    required String startDate,
    required String endDate,
  }) async {
    if (isLoading.value) return;

    isLoading.value = true;
    errorMessage.value = '';

    try {
      IncomeOrExpense? result =
          await TotalExpenseOrIncomeService().fetchTotalExpenseOrIncomeService(
        actionName: actionName,
        startDate: startDate,
        endDate: endDate,
      );

      if (result != null) {
        incomeOrExpenseData[actionName] = result;
      } else {
        errorMessage.value = 'Failed to fetch $actionName data';
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchAllData({
    required String startDate,
    required String endDate,
  }) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      await Future.wait([
        fetchData(actionName: "Income", startDate: startDate, endDate: endDate),
        fetchData(
            actionName: "Expense", startDate: startDate, endDate: endDate),
      ]);
    } catch (e) {
      errorMessage.value = 'An error occurred: $e';
    } finally {
      isLoading.value = false;
    }
  }
}
