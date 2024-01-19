// ignore_for_file: non_constant_identifier_names

class Cart {
  List<CartData>? data;

  Cart({this.data});

  Cart.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CartData>[];
      json['data'].forEach((v) {
        data!.add(CartData.fromJson(v));
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

class CartData {
  int id;
  int userId;
  int productId;
  int quantity;
  String product_price;
  String createdAt;
  String updatedAt;

  CartData({
    required this.id,
    required this.userId,
    required this.productId,
    required this.quantity,
    required this.product_price,
    required this.createdAt,
    required this.updatedAt,
  });

  CartData.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['user_id'],
        productId = json['product_id'],
        quantity = json['quantity'],
        product_price = json['product_price'],
        createdAt = json['created_at'],
        updatedAt = json['updated_at'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['product_id'] = productId;
    data['quantity'] = quantity;
    data['product_price'] = product_price;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
