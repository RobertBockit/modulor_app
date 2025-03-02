import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
class PickUpProvider with ChangeNotifier{
  late String pickupId = "";
  late String orderId;
  late String pickUpStatus = "";

  PickUpProvider({required this.orderId});

  Future<void> createPickUpProcess(jwt, apiUrl)async {
    var response = await http.post(
        Uri.parse('$apiUrl/orders/$orderId/start-pickup'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "Bearer $jwt"
        },
    );
    if(response.statusCode==201){
      var body = json.decode(response.body);
      pickupId = body["documentId"];
      pickUpStatus = body["progress"];
    }
    else{
      throw Exception(response.statusCode);
    }
  }

  Future<void> checkPickUpProgress(jwt, apiUrl) async{
    var response = await http.post(
      Uri.parse('$apiUrl/pickups/$pickupId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $jwt"
      },
    );
    if(response.statusCode==201){
      var body = json.decode(response.body);
      pickUpStatus = body["progress"];
    }
    else{
      throw Exception(response.statusCode);
    }
  }


}