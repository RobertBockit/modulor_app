import 'package:flutter/material.dart';
import 'package:modulor_app/constants/colors.dart';
import 'package:modulor_app/models/enums/currency.dart';
import 'package:modulor_app/providers/app_provider.dart';
import 'package:modulor_app/providers/cart_provider.dart';
import 'package:modulor_app/screens/retrieval_page.dart';
import 'package:provider/provider.dart';

import '../../models/price.dart';

class PayButtonBlock extends StatelessWidget {
  final Price totalPrice;

  const PayButtonBlock({
    super.key,
    required this.totalPrice,
  });



  @override
  Widget build(BuildContext context) {
    var jwtToken = "";
    Provider.of<AppProvider>(context, listen: false).jwt.then((val){jwtToken = val;});
    var api = Provider.of<AppProvider>(context, listen: false).apiUrl;
    return Container(
        width: double.infinity,
        height: 92,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
            padding:
                const EdgeInsets.only(top: 8, bottom: 15, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "Total amount: ${totalPrice.price.toStringAsFixed(2)}${totalPrice.currency.value}",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700)),
                      Text(
                          'VAT (7%) included: ${(totalPrice.price * 0.07).toStringAsFixed(2)}${totalPrice.currency.value}')
                    ]),
                ElevatedButton(
                  onPressed: () => {

                    Provider.of<CartProvider>(context, listen: false).confirmOrder(jwtToken, api, context),

                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.modulorRed,
                      shadowColor: Colors.transparent,
                      fixedSize: Size(190, 42),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(11)))),
                  child: Text(
                    "Pay Now",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                )
              ],
            )));
  }
}
