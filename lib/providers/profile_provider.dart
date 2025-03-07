import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:modulor_app/models/order_item.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'app_provider.dart';

class ProfileProvider extends ChangeNotifier {
  late Future<List<OrderItem>> _allOrders;
  late Future<List<OrderItem>> _activeOrders;

  Future<List<OrderItem>> get allOrders=>_allOrders;
  Future<List<OrderItem>> get activeOrders=>_activeOrders;

  List<OrderItem> sortOrders(arr){
    List<OrderItem> newArr = arr;
    newArr.sort((a,b) {
      return b.date.substring(0, 2).compareTo(a.date.substring(0, 2));
    });
    newArr.sort((a,b) {
      return b.date.substring(3).compareTo(a.date.substring(3));
    });
    return newArr;
  }


  Future<List<OrderItem>> getAllOrders(apiUrl, jwt) async {
    var response = await http.get(
      Uri.parse('$apiUrl/orders?populate=*&pagination[page]=2&pagination[pageSize]=25'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $jwt"
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      print("body");
      print(body);
      List<OrderItem> arr = body["data"].map<OrderItem>((e) => OrderItem.fromJson(e)).toList();
      return sortOrders(arr);
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<List<OrderItem>> getActiveOrders(apiUrl, jwt) async {
    var response = await http.get(
      Uri.parse('$apiUrl/orders?populate=*&filters[\$not][\$or][0][orderStatus][\$eq]=CANCELED&filters[\$not][\$or][1][orderStatus][\$eq]=COMPLETED&filters[\$not][\$or][2][orderStatus][\$eq]=UNPAID'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $jwt"
      },
    );
    if (response.statusCode == 200) {
      var body = json.decode(response.body);

      List<OrderItem>arr = body["data"].map<OrderItem>((e) => OrderItem.fromJson(e)).toList();
      return sortOrders(arr);
    } else {
      throw Exception(response.statusCode);
    }
  }

  ProfileProvider(context) {
    var api = Provider.of<AppProvider>(context, listen: false).apiUrl;

    Provider.of<AppProvider>(context, listen: false).jwt.then((val) {
      _allOrders = getAllOrders(api, val);
      _activeOrders = getActiveOrders(api, val);
      notifyListeners();
    });

  }
}
