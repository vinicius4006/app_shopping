import 'package:flutter/material.dart';
import 'package:gerenciamento_estado/models/cart.dart';
import 'package:provider/provider.dart';

class Badge extends StatelessWidget {
  final Widget child;

  final Color? color;
  const Badge({Key? key, required this.child, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
            right: 8,
            top: 8,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: color ?? Theme.of(context).errorColor),
              constraints: const BoxConstraints(minHeight: 16, minWidth: 16),
              child: Consumer<Cart>(
                builder: (context, cart, child) => Text(
                  cart.itemsCount.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 10),
                ),
              ),
            )),
      ],
    );
  }
}
