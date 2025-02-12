import 'package:flutter/material.dart';

import '../models/item.dart';
import '../models/order.dart';
import '../models/price.dart';

class CartProvider with ChangeNotifier {
  final Order _order = Order([]);

  List<Item> get items => _order.orderItems;

  num get totalAmount => _order.totalAmount;

  String get orderIdShort => _order.id.substring(0, 10);

  String get orderId => _order.id;

  Price get totalPrice => _order.totalPrice;

  void addItem(Item newItem) {
    _order.addNewProduct(newItem);
    notifyListeners();
  }

  retrieveItemAmount(String id) {
    for (var el in _order.orderItems) {
      if (el.productId == id) {
        return el.amount - 1;
      }
    }
    return 0;
  }

  void changeAmount(String id, num newAmount) {
    if (newAmount > 0) {
      for (var el in _order.orderItems) {
        if (el.productId == id) {
          el.amount = newAmount;
        }
      }
    } else {
      _order.removeProduct(id);
    }

    _order.calculateTotalAmount();
    _order.calculateTotalPrice();
    notifyListeners();
  }

  void removeItem(String productId) {
    _order.removeProduct(productId);
    notifyListeners();
  }

  void clearCart() {
    _order.clearOrder();
    notifyListeners();
  }
}
