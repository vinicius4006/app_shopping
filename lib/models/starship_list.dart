import 'package:flutter/material.dart';
import 'package:gerenciamento_estado/data/dummy_data.dart';
import 'package:gerenciamento_estado/models/starship.dart';

class StarshipList with ChangeNotifier {
  final List<Starship> _items = dummyProducts;

  List<Starship> get items => [..._items];
  List<Starship> get favoriteItems =>
      [..._items].where((prod) => prod.isFavorite).toList();

  int get itemsCount => _items.length;

  // void addProduct(Product product) {
  //   _items.add(product);
  //   notifyListeners();
  // }
}
