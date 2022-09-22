import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gerenciamento_estado/data/dummy_data.dart';
import 'package:gerenciamento_estado/models/starship.dart';

class StarshipList with ChangeNotifier {
  final List<Starship> _items = dummyProducts;

  List<Starship> get items => [..._items];
  List<Starship> get favoriteItems =>
      [..._items].where((prod) => prod.isFavorite).toList();

  int get itemsCount => _items.length;

  void saveStarship(Map<String, Object> data) {
    bool hasId = data['id'] != null;
    final newStarship = Starship(
        id: hasId ? data['id'] as String : Random().nextDouble().toString(),
        name: data['name'] as String,
        description: data['description'] as String,
        price: data['price'] as double,
        imageUrl: data['image'] as String);

    if (hasId) {
      updateStarship(newStarship);
    } else {
      addStarship(newStarship);
    }
  }

  void addStarship(Starship starship) {
    _items.add(starship);
    notifyListeners();
  }

  void updateStarship(Starship starship) {
    int index = _items.indexWhere((s) => s.id == starship.id);

    if (index >= 0) {
      _items[index] = starship;
      notifyListeners();
    }
  }

  void deleteStarship(String id) {
    _items.removeWhere((s) => s.id == id);
    notifyListeners();
  }
}
