import 'package:flutter/material.dart';
import 'package:gerenciamento_estado/models/cart_item.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;

  const CartItemWidget({Key? key, required this.cartItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(cartItem.name),
      subtitle: Text('Total: R\$ ${cartItem.price * cartItem.quantity}'),
      trailing: Text('${cartItem.quantity}x'),
    );
  }
}
