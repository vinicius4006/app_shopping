import 'dart:convert';

import 'package:gerenciamento_estado/models/cart_item.dart';

class Order {
  final String id;
  final int total;
  final List<CartItem> starships;
  final DateTime date;

  Order({
    required this.id,
    required this.total,
    required this.starships,
    required this.date,
  });

  String toJson() {
    final Map<String, dynamic> dados = <String, dynamic>{};
    dados['total'] = total;
    dados['starships'] = starships.map((s) => s.toJson()).toList();
    dados['date'] = date.toIso8601String();

    return jsonEncode(dados);
  }
}
