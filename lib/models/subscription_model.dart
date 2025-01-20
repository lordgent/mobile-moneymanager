class SubscriptionModel {
  String id;
  String name;
  String? icon;
  String description;
  String amount;
  String? createdAt;
  String? updatedAt;

  SubscriptionModel({
    required this.id,
    required this.name,
    this.icon,
    required this.description,
    required this.amount,
    this.createdAt,
    this.updatedAt,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionModel(
      id: json['id'],
      name: json['name'],
      icon: json['icon'],
      description: json['description'],
      amount: json['amount'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'description': description,
      'amount': amount.toString(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
