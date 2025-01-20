import 'dart:convert';

class ReportCategory {
  final String total;
  final String categoryName;

  ReportCategory({required this.total, required this.categoryName});

  factory ReportCategory.fromJson(Map<String, dynamic> json) {
    return ReportCategory(
        total: json['total'] ?? '', categoryName: json['categoryName'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'categoryName': categoryName,
    };
  }
}

class ReportCategoryModel {
  final List<ReportCategory> data;
  final String total;

  ReportCategoryModel({required this.data, required this.total});

  factory ReportCategoryModel.fromJson(Map<String, dynamic> json) {
    var list = json['financial_report'] as List;
    List<ReportCategory> dataList =
        list.map((i) => ReportCategory.fromJson(i)).toList();

    return ReportCategoryModel(data: dataList, total: json['total_all'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'financial_report': data.map((e) => e.toJson()).toList(),
      'total_all': total,
    };
  }
}

ReportCategoryModel parseReportCategoryModel(String jsonString) {
  final Map<String, dynamic> jsonResponse = json.decode(jsonString);
  return ReportCategoryModel.fromJson(jsonResponse);
}
