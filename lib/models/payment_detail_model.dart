import 'dart:convert';

class PaymentData {
  final String id;
  final String numberCode;
  final Payment payment;
  final String total;
  final String adminFee;
  final String amount;
  final String status;
  final DateTime createdAt;
  final String? expired;

  PaymentData({
    required this.id,
    required this.numberCode,
    required this.payment,
    required this.total,
    required this.adminFee,
    required this.amount,
    required this.status,
    required this.createdAt,
    this.expired,
  });

  factory PaymentData.fromJson(Map<String, dynamic> json) {
    return PaymentData(
      id: json['id'],
      numberCode: json['numberCode'],
      payment: Payment.fromJson(json['payment']),
      total: json['total'],
      adminFee: json['adminFee'],
      amount: json['amount'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      expired: json['expired'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'numberCode': numberCode,
      'payment': payment.toJson(),
      'total': total,
      'adminFee': adminFee,
      'amount': amount,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'expired': expired,
    };
  }
}

class Payment {
  final String id;
  final String name;
  final String icon;
  final String code;
  final PaymentCategory paymentCategory;

  Payment({
    required this.id,
    required this.name,
    required this.icon,
    required this.code,
    required this.paymentCategory,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['id'],
      name: json['name'],
      icon: json['icon'],
      code: json['code'],
      paymentCategory: PaymentCategory.fromJson(json['paymentCategory']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'code': code,
      'paymentCategory': paymentCategory.toJson(),
    };
  }
}

class PaymentCategory {
  final String id;
  final String name;
  final String? icon;
  final bool isDelete;

  PaymentCategory({
    required this.id,
    required this.name,
    this.icon,
    required this.isDelete,
  });

  factory PaymentCategory.fromJson(Map<String, dynamic> json) {
    return PaymentCategory(
      id: json['id'],
      name: json['name'],
      icon: json['icon'],
      isDelete: json['isDelete'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'isDelete': isDelete,
    };
  }
}
