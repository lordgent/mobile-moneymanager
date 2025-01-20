import 'package:moneymanager/models/VirtualAccountModel.dart';

class PaymentMethodsResponse {
  final List<VirtualAccountModel> virtualAccount;
  final dynamic ewallet;

  PaymentMethodsResponse({
    required this.virtualAccount,
    this.ewallet,
  });

  factory PaymentMethodsResponse.fromJson(Map<String, dynamic> json) {
    var virtualAccountList = json['virtualAccount'] as List;
    List<VirtualAccountModel> virtualAccounts =
        virtualAccountList.map((e) => VirtualAccountModel.fromJson(e)).toList();

    return PaymentMethodsResponse(
      virtualAccount: virtualAccounts,
      ewallet: json['ewallet'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'virtualAccount': virtualAccount.map((e) => e.toJson()).toList(),
      'ewallet': ewallet,
    };
  }
}
