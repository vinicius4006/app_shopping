import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gerenciamento_estado/models/cart_item.dart';
import 'package:gerenciamento_estado/models/starship.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemsCount {
    return _items.length;
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });

    return total;
  }

  void addItem(Starship starship) {
    if (_items.containsKey(starship.id)) {
      _items.update(
          starship.id,
          (existingItem) => CartItem(
              id: existingItem.id,
              starshipId: existingItem.starshipId,
              name: existingItem.name,
              quantity: existingItem.quantity + 1,
              price: existingItem.price));
    } else {
      _items.putIfAbsent(
          starship.id,
          () => CartItem(
              id: Random().nextDouble().toString(),
              starshipId: starship.id,
              name: starship.name,
              quantity: 1,
              price: starship.price));
    }
    notifyListeners();
  }

  void removeItem(String starshipId) {
    _items.remove(starshipId);
    notifyListeners();
  }

  void removeSingleItem(String starshipId) {
    if (!_items.containsKey(starshipId)) {
      return;
    }

    if (_items[starshipId]?.quantity == 1) {
      _items.remove(starshipId);
    } else {
      _items.update(
          starshipId,
          (existingItem) => CartItem(
              id: existingItem.id,
              starshipId: existingItem.starshipId,
              name: existingItem.name,
              quantity: existingItem.quantity - 1,
              price: existingItem.price));
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
