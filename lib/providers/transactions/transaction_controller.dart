import 'package:get/get.dart';
import 'package:moneymanager/models/transaction_model.dart';
import 'package:moneymanager/services/transaction/transaction_service.dart';
import 'package:moneymanager/utils/report_helper.dart';

class TransactionController extends GetxController {
  final TransactionService _transactionService = TransactionService();

  var todayTransactions = <TransactionModel>[].obs;
  var yesterdayTransactions = <TransactionModel>[].obs;

  var isLoadingToday = false.obs;
  var isLoadingYesterday = false.obs;
  var isMoreLoading = false.obs;
  var errorMessage = ''.obs;
  var isRefreshing = false.obs;

  var todayOffset = 0.obs;
  var yesterdayOffset = 0.obs;
  final int limit = 5;

  @override
  Future<void> onInit() async {
    super.onInit();
    await fetchTransactions(rangeType: "now");
    await fetchTransactions(rangeType: "yesterday");
  }

  Future<void> fetchTransactions({
    required String rangeType,
    bool isLoadMore = false,
  }) async {
    if ((rangeType == "now" && isLoadingToday.value) ||
        (rangeType == "yesterday" && isLoadingYesterday.value) ||
        isMoreLoading.value) {
      return;
    }

    if (rangeType == "now") {
      isLoadingToday.value = !isLoadMore;
    } else {
      isLoadingYesterday.value = !isLoadMore;
    }

    isMoreLoading.value = isLoadMore;
    errorMessage.value = '';

    try {
      final dateRange = DateHelper.getDateRange(rangeType);
      final currentOffset =
          rangeType == "now" ? todayOffset.value : yesterdayOffset.value;

      final fetchedTransactions =
          await _transactionService.fetchTransactionService(
        offset: currentOffset,
        limit: limit,
        startDate: dateRange['startDate'],
        endDate: dateRange['endDate'],
      );

      if (fetchedTransactions != null) {
        if (rangeType == "now") {
          if (isLoadMore) {
            todayTransactions.addAll(fetchedTransactions);
          } else {
            todayTransactions.assignAll(fetchedTransactions);
          }
          todayOffset.value += 1;
        } else if (rangeType == "yesterday") {
          if (isLoadMore) {
            yesterdayTransactions.addAll(fetchedTransactions);
          } else {
            yesterdayTransactions.assignAll(fetchedTransactions);
          }
          yesterdayOffset.value += 1;
        }
      } else {
        errorMessage.value = 'Failed to fetch transactions.';
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: $e';
    } finally {
      if (rangeType == "now") {
        isLoadingToday.value = false;
      } else {
        isLoadingYesterday.value = false;
      }
      isMoreLoading.value = false;
    }
  }

  Future<void> refreshData({required String rangeType}) async {
    if (isRefreshing.value) return;
    isRefreshing.value = true;

    try {
      if (rangeType == "now") {
        todayOffset.value = 0;
      } else if (rangeType == "yesterday") {
        yesterdayOffset.value = 0;
      }

      await fetchTransactions(rangeType: rangeType);
    } catch (e) {
      errorMessage.value = 'Failed to refresh data: $e';
    } finally {
      isRefreshing.value = false;
    }
  }
}
