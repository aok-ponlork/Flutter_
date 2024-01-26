class User {
  final int? userId;
  final String? userName;
  final String? createdAt;
  final String? userEmail;
  final String? totalSpend;

  User({
    this.userId,
    this.userName,
    this.createdAt,
    this.userEmail,
    this.totalSpend,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'],
      userName: json['user_name'],
      createdAt: json['created_at'],
      userEmail: json['user_email'],
      totalSpend: json['total_spend'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'user_name': userName,
      'created_at': createdAt,
      'user_email': userEmail,
      'total_spend': totalSpend,
    };
  }
}
