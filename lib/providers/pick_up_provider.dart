import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
class PickUpProvider with ChangeNotifier{
  late String pickupId = "";
  late String pickUpStatus = "";

  Future<void> createPickUpProcess(jwt, apiUrl, orderId)async {
    print(jwt);
    var response = await http.post(
        Uri.parse('$apiUrl/orders/$orderId/start-pickup'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "Bearer $jwt"
        },
    );
    if(response.statusCode==201){
      var body = json.decode(response.body);
      pickupId = body["data"]["documentId"];
      pickUpStatus = body["data"]["progress"];
      print(body);
      notifyListeners();

    }
    else{
      throw Exception(response.statusCode);
    }
  }

  Future<void> checkPickUpProgress(jwt, apiUrl) async{
    var response = await http.get(
      Uri.parse('$apiUrl/pickups/$pickupId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $jwt"
      },
    );
    if(response.statusCode==200){
      var body = json.decode(response.body);
      pickUpStatus = body["data"]["progress"];
      notifyListeners();

    }
    else{
      throw Exception(response.statusCode);
    }
  }


}