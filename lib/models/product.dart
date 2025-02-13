import 'package:modulor_app/models/price.dart';
import 'enums/currency.dart';
var sourceUrl = "https://mad-shop.onrender.com";

class Product {
  final String id;
  final String img;
  final String title;
  final String description;
  final Price price;
  final String category;
  final DateTime createdAt;
  final DateTime updatedAt;

  Product(
      {required this.id,
      required this.img,
      required this.title,
      required this.description,
      required this.price,
      required this.category,
      required this.createdAt,
      required this.updatedAt});

  static double checkDouble(dynamic value) {
    if (value is String) {
      return double.parse(value);
    } else {
      return value.toDouble();
    }
  }


  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'].toString(),
      title: json['name'],
      description: json['description'],
      price: Price(Currency.euro, checkDouble(json['price']['netPrice'])),
      category: "",
      img: json['images'][0]["formats"]["thumbnail"]["url"],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
