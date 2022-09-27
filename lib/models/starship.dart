import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gerenciamento_estado/exceptions/http_Exception.dart';
import 'package:gerenciamento_estado/utils/constants.dart';
import 'package:http/http.dart' as http;
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

  void _toggleFavorite() {
    debugPrint('pass');
    isFavorite = !isFavorite;
    notifyListeners();
  }

  Future<void> toggleFavorite(String token, String userId) async {
    try {
      _toggleFavorite();

      final response = await http.put(
          Uri.parse(
              '${Constants.USER_FAVORITES_URL}/$userId/$id.json?auth=$token'),
          body: jsonEncode({"isFavorite": isFavorite}));

      if (response.statusCode >= 400) {
        _toggleFavorite();
        throw HttpException(
            msg: 'Não foi possível salvar', statusCode: response.statusCode);
      }
    } catch (_) {
      throw HttpException(msg: 'Erro ao favoritar', statusCode: 0);
    }
  }

  String toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['name'] = name;
    data['model'] = model;
    data['cost_in_credits'] = costInCredits;
    data['length'] = size;
    data['passengers'] = passengers;
    data['manufacturer'] = manufacturer;
    data['imageUrl'] = imageUrl;

    return jsonEncode(data);
  }

  static Starship fromJson(Map<String, dynamic> json) {
    return Starship(
        id: json['starship_id'],
        name: json['name'],
        model: '',
        size: 0,
        costInCredits: json['cost_in_credits'],
        passengers: json['quantity'],
        manufacturer: '',
        imageUrl: '');
  }

  @override
  String toString() =>
      'Starship(manunfacturer: $manufacturer, length: $size, isFavorite: $isFavorite)';
}
