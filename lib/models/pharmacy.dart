import 'dart:convert';

class Address {
  final int id;
  final String city;
  final String country;
  final String street;

  Address({
    required this.id,
    required this.city,
    required this.country,
    required this.street,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'] as int,
      city: json['city'] as String,
      country: json['country'] as String,
      street: json['street'] as String,
    );
  }
}

class Location {
  final int id;
  final double latitude;
  final double longitude;
  final Address address;

  Location({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'] as int,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      address: Address.fromJson(json['address'] as Map<String, dynamic>),
    );
  }
}

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

class Pharmacy {
  final int id;
  final String name;
  final String description;
  final String phone;
  final List<Product> products;
  final Location location;
  final String type;      
  final String imageUrl;

  Pharmacy({
    required this.id,
    required this.name,
    required this.description,
    required this.phone,
    required this.products,
    required this.location,
    required this.type,
    required this.imageUrl,
  });

  factory Pharmacy.fromJson(Map<String, dynamic> json) {
    final productsJson = json['products'] as List<dynamic>;
    List<Product> productsList = productsJson
        .map((item) => Product.fromJson(item as Map<String, dynamic>))
        .toList();

    return Pharmacy(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      phone: json['phone'] as String,
      products: productsList,
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
      type: json['type'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }

  static List<Pharmacy> listFromJson(String jsonString) {
    final List<dynamic> decoded = json.decode(jsonString);
    return decoded
        .map((item) => Pharmacy.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
