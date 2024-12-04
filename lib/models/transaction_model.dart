import 'dart:convert';

class TransactionModel {
  final String id;
  final String title;
  final String description;
  final String total;
  final User user;
  final Category category;
  final String createdAt;

  TransactionModel({
    required this.id,
    required this.title,
    required this.description,
    required this.total,
    required this.user,
    required this.category,
    required this.createdAt,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      total: json['total'],
      user: User.fromJson(json['user']),
      category: Category.fromJson(json['category']),
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'total': total,
      'user': user.toJson(),
      'category': category.toJson(),
      'createdAt': createdAt,
    };
  }
}

class User {
  final String id;
  final String fullName;
  final String email;

  User({
    required this.id,
    required this.fullName,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fullName: json['fullName'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
    };
  }
}

class Category {
  final String id;
  final String name;
  final String icon;

  Category({
    required this.id,
    required this.name,
    required this.icon,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
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

