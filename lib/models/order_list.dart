import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gerenciamento_estado/models/cart.dart';
import 'package:gerenciamento_estado/models/cart_item.dart';
import 'package:gerenciamento_estado/models/order.dart';
import 'package:gerenciamento_estado/utils/constants.dart';
import 'package:http/http.dart' as http;

class OrderList with ChangeNotifier {
  final List<Order> _items = [];

  List<Order> get items => [..._items];

  int get itemsCount => _items.length;

  Future<void> loadOrders() async {
    _items.clear();

    final response =
        await http.get(Uri.parse('${Constants.ORDER_BASE_URL}.json'));
    Map<String, dynamic> data = jsonDecode(response.body) ?? {};
    if (data != {}) {
      data.forEach((orderId, orderData) {
        debugPrint('$orderData');
        _items.add(Order(
            id: orderId,
            total: orderData['total'],
            starships: (orderData['starships'] as List)
                .map((c) => CartItem(
                    id: jsonDecode(c)['id'],
                    starshipId: jsonDecode(c)['starship_id'],
                    name: jsonDecode(c)['name'],
                    quantity: jsonDecode(c)['quantity'],
                    costInCredits: jsonDecode(c)['cost_in_credits']))
                .toList(),
            date: DateTime.parse(orderData['date'])));
      });
    }

    notifyListeners();
  }

  Future<void> addOrder(Cart cart) async {
    final response = await http.post(
        Uri.parse('${Constants.ORDER_BASE_URL}.json'),
        body: cart.toJson());
    final id = jsonDecode(response.body)['name'];

    _items.insert(
        0,
        Order(
            id: id,
            total: cart.totalAmount,
            starships: cart.items.values.toList(),
            date: cart.date));
    notifyListeners();
  }
}
