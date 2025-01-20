class VirtualAccountModel {
  final String icon;
  final String name;
  final String code;
  final String categoryName;

  VirtualAccountModel({
    required this.icon,
    required this.name,
    required this.code,
    required this.categoryName,
  });

  // Factory constructor to create VirtualAccountModel from JSON
  factory VirtualAccountModel.fromJson(Map<String, dynamic> json) {
    return VirtualAccountModel(
      icon: json['icon'],
      name: json['name'],
      code: json['code'],
      categoryName: json['paymentCategory']['name'], // Extract category name
    );
  }

  // Convert VirtualAccountModel instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'icon': icon,
      'name': name,
      'code': code,
      'categoryName': categoryName,
    };
  }
}
