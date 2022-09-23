import 'package:flutter/material.dart';
import 'package:gerenciamento_estado/components/cart_item.dart';
import 'package:gerenciamento_estado/models/cart.dart';
import 'package:gerenciamento_estado/models/order_list.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('Build CartPage');
    final cart = context.watch<Cart>();
    final items = cart.items.values.toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(25),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Chip(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    label: Text(
                      cart.totalAmount.toString(),
                      style: TextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .headline6
                              ?.color),
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                      style: TextButton.styleFrom(
                          textStyle:
                              TextStyle(color: Theme.of(context).primaryColor)),
                      onPressed: () {
                        if (cart.itemsCount == 0) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Carrinho vazio'),
                            duration: Duration(seconds: 2),
                          ));
                        } else {
                          context.read<OrderList>().addOrder(cart);
                          cart.clear();
                        }
                      },
                      child: const Text('COMPRAR'))
                ],
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) =>
                      CartItemWidget(cartItem: items[index])))
        ],
      ),
    );
  }
}
