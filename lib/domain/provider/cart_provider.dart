import 'package:flutter/foundation.dart';

class CartProvider with ChangeNotifier {
  final Map<int, int> _items = {}; // key: foodId (int), value: quantity

  Map<int, int> get items => _items;

  void addToCart(int foodId) {
    if (_items.containsKey(foodId)) {
      _items[foodId] = _items[foodId]! + 1;
    } else {
      _items[foodId] = 1;
    }
    notifyListeners();
  }

  void removeFromCart(int foodId) {
    _items.remove(foodId);
    notifyListeners();
  }


  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  List<Map<String, dynamic>> getOrderData() {
    return _items.entries
        .map((entry) => {
      'food_id': entry.key,     // int type
      'quantity': entry.value,
    })
        .toList();
  }
}
