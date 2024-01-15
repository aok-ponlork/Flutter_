class Products {
  List<ProductData>? data;

  Products({this.data});

  factory Products.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      List<ProductData> dataList = [];
      json['data'].forEach((v) {
        dataList.add(ProductData.fromJson(v));
      });
      return Products(data: dataList);
    } else {
      return Products();
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

class ProductData {
  String? id;
  Attributes? attributes;
  Relationship? relationship;

  ProductData({this.id, this.attributes, this.relationship});

  ProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributes = json['attributes'] != null
        ? Attributes.fromJson(json['attributes'])
        : null;
    relationship = json['relationship'] != null
        ? Relationship.fromJson(json['relationship'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (attributes != null) {
      data['attributes'] = attributes!.toJson();
    }
    if (relationship != null) {
      data['relationship'] = relationship!.toJson();
    }
    return data;
  }
}

class Attributes {
  String? productName;
  double? price;
  double? cost;
  int? stockQty;
  String? description;
  String? image;
  String? createdAt;
  String? updatedAt;

  Attributes(
      {this.productName,
      this.price,
      this.cost,
      this.stockQty,
      this.description,
      this.image,
      this.createdAt,
      this.updatedAt});

  Attributes.fromJson(Map<String, dynamic> json) {
    productName = json['product_name'];
    price = json['price'];
    cost = json['cost'];
    stockQty = json['stock_qty'];
    description = json['description'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_name'] = productName;
    data['price'] = price;
    data['cost'] = cost;
    data['stock_qty'] = stockQty;
    data['description'] = description;
    data['image'] = image;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Relationship {
  int? categoryId;
  String? categoryName;

  Relationship({this.categoryId, this.categoryName});

  Relationship.fromJson(Map<String, dynamic> json) {
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
