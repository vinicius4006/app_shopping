import 'package:flutter/material.dart';

import 'package:gerenciamento_estado/models/starship_base.dart';

class Starship extends StarshipBase with ChangeNotifier {
  final String description, imageUrl;
  bool isFavorite = false;

  Starship(
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

  @override
  String toString() =>
      'Starship(id: $id, name: $name, description: $description, price: $price,image: $imageUrl, isFavorite: $isFavorite)';
}
