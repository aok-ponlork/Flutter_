class Products {
  int? id;
  String? title;
  double? price;
  String? description;
  String? category;
  String? image;
  int? inCartQty;

  Products({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.inCartQty = 1,
  });

  Products.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      id = json['id'] as int?;
      title = json['title'] as String?;
      price = json['price']?.toDouble() as double?;
      description = json['description'] as String?;
      category = json['category'] as String?;
      image = json['image'] as String?;
      inCartQty = json['inCartQty'] as int? ?? 1;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['price'] = price;
    data['description'] = description;
    data['category'] = category;
    data['image'] = image;
    data['inCartQty'] = inCartQty; // Include inCartQty in toJson
    return data;
  }
}
