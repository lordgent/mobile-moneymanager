import 'package:get/get.dart';
import 'package:moneymanager/providers/transactions/transaction_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransactionController>(() => TransactionController());
  }
}
