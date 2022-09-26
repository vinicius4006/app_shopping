import 'package:flutter/material.dart';
import 'package:gerenciamento_estado/components/app_drawer.dart';
import 'package:gerenciamento_estado/components/order.dart';
import 'package:gerenciamento_estado/models/order_list.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Pedidos'),
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
          future: context.read<OrderList>().loadOrders(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.error != null) {
              return const Center(
                child: Text('Ocorreu um erro'),
              );
            } else {
              return Consumer<OrderList>(
                builder: (context, order, _) => ListView.builder(
                    itemCount: order.itemsCount,
                    itemBuilder: (context, index) => OrderWidget(
                          order: order.items[index],
                        )),
              );
            }
          }),
    );
  }
}
