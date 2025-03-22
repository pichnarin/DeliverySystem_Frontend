import 'package:flutter/foundation.dart';
import '../model/costumer model/food.dart';
// import '../model/food.dart';

class CartItem {
  final Food food;
  final String size;
  final int quantity;

  CartItem({
    required this.food,
    required this.size,
    required this.quantity,
  });
}

class CartProvider with ChangeNotifier {
  // Old structure: Map<String, CartItem>
  final Map<String, CartItem> _cartItems = {};
  
  // New structure: Map<int, int>
  final Map<int, int> _items = {}; // key: foodId (int), value: quantity

  // Getters for both structures
  Map<String, CartItem> get cartItems => _cartItems;
  Map<int, int> get items => _items;
  
  // For backward compatibility
  List<CartItem> get cartItemsList => _cartItems.values.toList();

  int get itemCount {
    return _cartItems.length;
  }

  // Add to cart with size (old method)
  void addToCart(Food food, String size, int quantity) {
    final String cartItemId = '${food.id}_$size';
    
    if (_cartItems.containsKey(cartItemId)) {
      // If the item already exists in the cart, update the quantity
      _cartItems.update(
        cartItemId,
        (existingItem) => CartItem(
          food: existingItem.food,
          size: existingItem.size,
          quantity: existingItem.quantity + quantity,
        ),
      );
    } else {
      // Otherwise, add a new item to the cart
      _cartItems.putIfAbsent(
        cartItemId,
        () => CartItem(
          food: food,
          size: size,
          quantity: quantity,
        ),
      );
    }
    
    // Also update the new structure
    if (_items.containsKey(food.id)) {
      _items[food.id] = _items[food.id]! + quantity;
    } else {
      _items[food.id] = quantity;
    }
    
    notifyListeners();
  }

  // Add to cart without size (new method)
  void addToCartSimple(int foodId) {
    if (_items.containsKey(foodId)) {
      _items[foodId] = _items[foodId]! + 1;
    } else {
      _items[foodId] = 1;
    }
    notifyListeners();
  }

  double get totalAmount {
    double total = 0.0;
    _cartItems.forEach((key, cartItem) {
      // Calculate price based on size
      double price = cartItem.food.price;
      if (cartItem.size == 'S') {
        price = cartItem.food.price * 0.8; // 20% less for small
      } else if (cartItem.size == 'L') {
        price = cartItem.food.price * 1.2; // 20% more for large
      }
      total += price * cartItem.quantity;
    });
    return total;
  }

  // Remove from cart by cartItemId (old method)
  void removeFromCart(String cartItemId) {
    if (_cartItems.containsKey(cartItemId)) {
      // Also update the new structure
      final parts = cartItemId.split('_');
      if (parts.length > 0) {
        final foodId = int.tryParse(parts[0]);
        if (foodId != null) {
          _items.remove(foodId);
        }
      }
      
      _cartItems.remove(cartItemId);
      notifyListeners();
    }
  }

  // Remove from cart by foodId (new method)
  void removeFromCartSimple(int foodId) {
    _items.remove(foodId);
    
    // Also update the old structure
    _cartItems.removeWhere((key, item) => item.food.id == foodId);
    
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    _items.clear();
    notifyListeners();
  }

  // For the new API
  List<Map<String, dynamic>> getOrderData() {
    return _items.entries
        .map((entry) => {
              'food_id': entry.key,     // int type
              'quantity': entry.value,
            })
        .toList();
  }
  
  // For the old API
  List<Map<String, dynamic>> getOrderDataDetailed() {
    return _cartItems.values
        .map((item) => {
              'food_id': item.food.id,
              'size': item.size,
              'quantity': item.quantity,
              'price': item.food.price,
            })
        .toList();
  }
  
  // Increase quantity of an item
  void increaseQuantity(CartItem item) {
    final String cartItemId = '${item.food.id}_${item.size}';
    if (_cartItems.containsKey(cartItemId)) {
      _cartItems.update(
        cartItemId,
        (existingItem) => CartItem(
          food: existingItem.food,
          size: existingItem.size,
          quantity: existingItem.quantity + 1,
        ),
      );
      
      // Also update the new structure
      if (_items.containsKey(item.food.id)) {
        _items[item.food.id] = _items[item.food.id]! + 1;
      }
      
      notifyListeners();
    }
  }
  
  // Decrease quantity of an item
  void decreaseQuantity(CartItem item) {
    final String cartItemId = '${item.food.id}_${item.size}';
    if (_cartItems.containsKey(cartItemId)) {
      if (_cartItems[cartItemId]!.quantity > 1) {
        _cartItems.update(
          cartItemId,
          (existingItem) => CartItem(
            food: existingItem.food,
            size: existingItem.size,
            quantity: existingItem.quantity - 1,
          ),
        );
        
        // Also update the new structure
        if (_items.containsKey(item.food.id) && _items[item.food.id]! > 1) {
          _items[item.food.id] = _items[item.food.id]! - 1;
        }
      } else {
        // If quantity becomes 0, remove the item
        removeFromCart(cartItemId);
      }
      
      notifyListeners();
    }
  }
  
  // Remove an item completely
  void removeItem(CartItem item) {
    final String cartItemId = '${item.food.id}_${item.size}';
    removeFromCart(cartItemId);
  }
}

