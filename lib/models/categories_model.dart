class CategoriesModel {
  final String id;
  final String name;
  final String icon;

  CategoriesModel({
    required this.id,
    required this.name,
    required this.icon,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(
      id: json['id'],
      name: json['name'],
      icon: json['icon'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
    };
  }
}