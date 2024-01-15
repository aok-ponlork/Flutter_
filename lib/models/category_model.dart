class Category {
  List<DataCategory>? data;

  Category({this.data});

  Category.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <DataCategory>[];
      json['data'].forEach((v) {
        data!.add(DataCategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataCategory {
  int? categoryId;
  String? categoryName;

  DataCategory({this.categoryId, this.categoryName});

  DataCategory.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
    return data;
  }
}