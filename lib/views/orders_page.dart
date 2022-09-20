import 'package:flutter/material.dart';
import 'package:gerenciamento_estado/components/app_drawer.dart';
import 'package:gerenciamento_estado/components/order.dart';
import 'package:gerenciamento_estado/models/order_list.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderList orders = context.watch<OrderList>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Pedidos'),
      ),
      drawer: const AppDrawer(),
      body: ListView.builder(
          itemCount: orders.itemsCount,
          itemBuilder: (context, index) => OrderWidget(
                order: orders.items[index],
              )),
    );
  }
}
