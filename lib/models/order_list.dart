import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gerenciamento_estado/models/cart.dart';
import 'package:gerenciamento_estado/models/cart_item.dart';
import 'package:gerenciamento_estado/models/order.dart';
import 'package:gerenciamento_estado/utils/constants.dart';
import 'package:http/http.dart' as http;

class OrderList with ChangeNotifier {
  final String _token;
  List<Order> _items;
  final String _userId;
  OrderList([this._token = '', this._userId = '', this._items = const []]);

  List<Order> get items => [..._items];

  int get itemsCount => _items.length;

  Future<void> loadOrders() async {
    List<Order> items = [];

    final response = await http.get(
        Uri.parse('${Constants.ORDER_BASE_URL}/$_userId.json?auth=$_token'));
    Map<String, dynamic> data = jsonDecode(response.body) ?? {};
    if (data != {}) {
      data.forEach((orderId, orderData) {
        debugPrint('$orderData');
        items.add(Order(
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
    _items = items.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(Cart cart) async {
    final response = await http.post(
        Uri.parse('${Constants.ORDER_BASE_URL}/$_userId.json?auth=$_token'),
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
