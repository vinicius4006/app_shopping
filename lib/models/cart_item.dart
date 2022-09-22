import 'package:gerenciamento_estado/models/starship_base.dart';

class CartItem extends StarshipBase {
  final String starshipId;
  final int quantity;

  CartItem(
      {required super.id,
      required this.starshipId,
      required super.name,
      required this.quantity,
      required super.price});
}
