import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:modulor_app/models/enums/currency.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

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

  void toggleIsSelected(String id, bool isSelected){
    for (var el in _order.orderItems) {
      if (el.productId == id) {
        el.isSelected = isSelected;
      }
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

  void confirmOrder(jwt, apiUrl) async{
    var response = await http.post(
      Uri.parse('$apiUrl/orders?populate=*'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $jwt"
      },
      body: json.encode({
        "data": {
          "orderStatus": "UNPAID",
          "issue": true,
          "items": _order.orderItems.map((element){

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
      // print(await response.stream.bytesToString());
      var body = json.decode(response.body);
      print(body);
    }
    else{
      throw Exception(response.statusCode);
    }
  }
}
