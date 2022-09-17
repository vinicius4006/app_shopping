import 'package:flutter/material.dart';
import 'package:gerenciamento_estado/models/product_base.dart';

class Product extends ProductBase with ChangeNotifier {
  final String description, imageUrl;
  bool isFavorite;

  Product(
      {required super.id,
      required super.name,
      required this.description,
      required super.price,
      required this.imageUrl,
      this.isFavorite = false});

  void toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
