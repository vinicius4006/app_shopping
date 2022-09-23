import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gerenciamento_estado/models/starship.dart';
import 'package:http/http.dart' as http;

class StarshipList with ChangeNotifier {
  final _baseUrl =
      'https://starships-cod3r-default-rtdb.firebaseio.com/starships';
  final List<Starship> _items = [];

  List<Starship> get items => [..._items];
  List<Starship> get favoriteItems =>
      [..._items].where((prod) => prod.isFavorite).toList();

  int get itemsCount => _items.length;

  Future<void> loadStarships() async {
    _items.clear();
    final response = await http.get(Uri.parse('$_baseUrl.json'));
    Map<String, dynamic> data = jsonDecode(response.body) ?? {};
    if (data != {}) {
      data.forEach((starshipId, starshipData) {
        _items.add(Starship(
            id: starshipId,
            name: starshipData['name'],
            manufacturer: starshipData['manufacturer'],
            costInCredits: starshipData['cost_in_credits'],
            size: double.parse(
                starshipData['length'].toString().replaceAll(',', '.')),
            model: starshipData['model'],
            passengers: starshipData['passengers'],
            imageUrl: starshipData['imageUrl']));
      });
    }

    notifyListeners();
  }

  Future<void> saveStarship(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final newStarship = Starship(
        id: hasId ? data['id'] as String : Random().nextDouble().toString(),
        name: data['name'] as String,
        manufacturer: data['manufacturer'] as String,
        costInCredits: data['cost_in_credits'] as int,
        size: data['length'] as double,
        model: data['model'] as String,
        passengers: data['passengers'] as int,
        imageUrl: data['imageUrl'] as String);

    debugPrint('$newStarship');

    if (hasId) {
      return updateStarship(newStarship);
    } else {
      return addStarship(newStarship);
    }
  }

  Future<void> addStarship(Starship starship) async {
    final response = await http.post(Uri.parse('$_baseUrl.json'),
        body: jsonEncode(starship.toJson()));

    final id = jsonDecode(response.body)['name'];
    _items.add(Starship(
        id: id,
        name: starship.name,
        manufacturer: starship.manufacturer,
        costInCredits: starship.costInCredits,
        model: starship.model,
        passengers: starship.passengers,
        size: starship.size,
        imageUrl: starship.imageUrl,
        isFavorite: starship.isFavorite));
    notifyListeners();
  }

  Future<void> updateStarship(Starship starship) async {
    int index = _items.indexWhere((s) => s.id == starship.id);

    if (index >= 0) {
      await http.patch(Uri.parse('$_baseUrl/${starship.id}.json'),
          body: jsonEncode(starship.toJson()));
      _items[index] = starship;
      notifyListeners();
    }
  }

  void deleteStarship(String id) {
    _items.removeWhere((s) => s.id == id);
    notifyListeners();
  }
}
