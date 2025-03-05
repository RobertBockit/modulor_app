import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:modulor_app/models/enums/currency.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../models/item.dart';
import '../models/order.dart';
import '../models/price.dart';
import '../screens/retrieval_page.dart';

class CartProvider with ChangeNotifier {
  final Order _order = Order([]);

  List<Item> get items => _order.orderItems;

  num get totalAmount => _order.totalAmount;

  String get orderIdShort => _order.id.substring(0, 10);

  String get orderId => _order.id;

  Price get totalPrice => _order.totalPrice;

  Order get order => _order;

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

  bool get areAllItemsSelected {
    return _order.orderItems.every((el) => el.isSelected);
  }

  // Toggle selection for a single item
  void toggleIsSelected(String id, bool isSelected) {
    for (var el in _order.orderItems) {
      if (el.productId == id) {
        el.isSelected = isSelected;
      }
    }
    _order.calculateTotalAmount();
    _order.calculateTotalPrice();

    // Notify listeners to update the UI
    notifyListeners();
  }

  // Toggle selection for all items
  void toggleAllSelected(bool isSelected) {
    for (var el in _order.orderItems) {
      el.isSelected = isSelected; // Toggle the selection for all items
    }
    _order.calculateTotalAmount();
    _order.calculateTotalPrice();
    notifyListeners();
  }

  // Method to update the "Select All" button state
  void updateSelectAllState() {
    bool newSelectAllState = areAllItemsSelected;
    notifyListeners();
  }

  void removeItem(String productId) {
    _order.removeProduct(productId);
    notifyListeners();
  }

  void clearCart() {
    for (var item in List.from(_order.orderItems)) {
      _order.removeProduct(item.productId);
    }
    notifyListeners();
  }

  void confirmOrder(jwt, apiUrl, context) async {
    var response = await http.post(
        Uri.parse('$apiUrl/orders?populate=*'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "Bearer $jwt"
        },
        body: json.encode({
          "data": {
            "orderStatus": "PAID",
            "issue": true,
            "items": _order.orderItems.map((element) {
              return {
                "product": element.productId,
                "quantity": element.amount,
                "price": {
                  "netPrice": element.productPrice.price,
                  "currency": element.productPrice.currency.name,
                  "vatRate": 0.19
                }
              };
            }).toList()
          }
        })
    );
    if (response.statusCode == 201) {
      var body = json.decode(response.body);
      _order.id = body["data"]["documentId"];
      print(_order.id);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RetrievalPage(),
          )
      );
    } else {
      throw Exception(response.statusCode);
    }
  }
}
