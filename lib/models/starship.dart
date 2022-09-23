import 'package:flutter/material.dart';

import 'package:gerenciamento_estado/models/starship_base.dart';

class Starship extends StarshipBase with ChangeNotifier {
  late final String model, imageUrl, manufacturer;
  late final double size;
  late final int passengers;
  bool isFavorite = false;

  Starship(
      {required super.id,
      required super.name,
      required this.model,
      required this.size,
      required super.costInCredits,
      required this.passengers,
      required this.manufacturer,
      required this.imageUrl,
      this.isFavorite = false});

  void toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['name'] = name;
    data['model'] = model;
    data['cost_in_credits'] = costInCredits;
    data['length'] = size;
    data['passengers'] = passengers;
    data['manufacturer'] = manufacturer;
    data['imageUrl'] = imageUrl;
    data['isFavorite'] = isFavorite;

    return data;
  }

  @override
  String toString() =>
      'Starship(manunfacturer: $manufacturer, length: $size, isFavorite: $isFavorite)';
}
