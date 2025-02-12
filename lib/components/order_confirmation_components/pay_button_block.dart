import 'package:flutter/material.dart';
import 'package:modulor_app/constants/colors.dart';
import 'package:modulor_app/models/enums/currency.dart';

import '../../models/price.dart';

class PayButtonBlock extends StatelessWidget {
  final Price totalPrice;

  const PayButtonBlock({
    super.key,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        // color: Colors.white,
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
                          "Total amount: ${totalPrice.price}${totalPrice.currency.value}",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700)),
                      Text(
                          'VAT (7%) included: ${(totalPrice.price * 0.07).toStringAsFixed(2)}${totalPrice.currency.value}')
                    ]),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.modulorRed,
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
