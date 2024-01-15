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
  String createdAt;
  String updatedAt;

  CartData({
    required this.id,
    required this.userId,
    required this.productId,
    required this.quantity,
    required this.createdAt,
    required this.updatedAt,
  });

  CartData.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['user_id'],
        productId = json['product_id'],
        quantity = json['quantity'],
        createdAt = json['created_at'],
        updatedAt = json['updated_at'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['product_id'] = productId;
    data['quantity'] = quantity;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
