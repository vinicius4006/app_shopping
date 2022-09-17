import 'package:gerenciamento_estado/models/product_base.dart';

class CartItem extends ProductBase {
  final String productId;
  final int quantity;

  CartItem(
      {required super.id,
      required this.productId,
      required super.name,
      required this.quantity,
      required super.price});
}
