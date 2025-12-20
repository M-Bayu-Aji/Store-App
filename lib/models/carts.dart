class UserCart {
  int id;
  int userId;
  DateTime date;
  List<CartProduct> products;

  UserCart({
    required this.id,
    required this.userId,
    required this.date,
    required this.products,
  });

  factory UserCart.fromJson(Map<String, dynamic> json) => UserCart(
        id: json["id"],
        userId: json["userId"],
        date: DateTime.parse(json["date"]),
        products: List<CartProduct>.from(
          json["products"].map((x) => CartProduct.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "date": date.toIso8601String(),
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class CartProduct {
  int productId;
  int quantity;

  CartProduct({
    required this.productId,
    required this.quantity,
  });

  factory CartProduct.fromJson(Map<String, dynamic> json) => CartProduct(
        productId: json["productId"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "quantity": quantity,
      };
}

class UserData {
  int id;
  String email;
  String username;
  Name name;
  String phone;

  UserData({
    required this.id,
    required this.email,
    required this.username,
    required this.name,
    required this.phone,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"],
        email: json["email"],
        username: json["username"],
        name: Name.fromJson(json["name"]),
        phone: json["phone"],
      );

  String get fullName => '${name.firstname} ${name.lastname}';
}

class Name {
  String firstname;
  String lastname;

  Name({
    required this.firstname,
    required this.lastname,
  });

  factory Name.fromJson(Map<String, dynamic> json) => Name(
        firstname: json["firstname"],
        lastname: json["lastname"],
      );
}

