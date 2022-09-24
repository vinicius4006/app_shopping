import 'dart:convert';

import 'package:gerenciamento_estado/models/starship_base.dart';

class CartItem extends StarshipBase {
  final String starshipId;
  final int quantity;

  CartItem(
      {required super.id,
      required this.starshipId,
      required super.name,
      required this.quantity,
      required super.costInCredits});

  String toJson() {
    final Map<String, dynamic> dados = <String, dynamic>{};
    dados['starship_id'] = starshipId;
    dados['name'] = name;
    dados['quantity'] = quantity;
    dados['cost_in_credits'] = costInCredits;

    return jsonEncode(dados);
  }
}
