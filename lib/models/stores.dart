import 'dart:convert';

class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final String type;
  final int barcode;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.type,
    required this.barcode,
    required this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      type: json['type'] as String,
      barcode: json['barcode'] as int,
      imageUrl: json['imageUrl'] as String,
    );
  }
}

class Market {
  final int id;
  final String name;
  final String description;
  final String phone;
  final String imageUrl; 
  final List<Product> products;

  Market({
    required this.id,
    required this.name,
    required this.description,
    required this.phone,
    required this.imageUrl, 
    required this.products,
  });

  factory Market.fromJson(Map<String, dynamic> json) {
    final productsJson = json['products'] as List<dynamic>;
    List<Product> productsList =
        productsJson.map((e) => Product.fromJson(e)).toList();

    return Market(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      phone: json['phone'] as String,
      imageUrl: json['imageUrl'] as String, 
      products: productsList,
    );
  }

  static List<Market> listFromJson(String jsonString) {
    final List<dynamic> decoded = json.decode(jsonString);
    return decoded.map((item) => Market.fromJson(item)).toList();
  }
}
