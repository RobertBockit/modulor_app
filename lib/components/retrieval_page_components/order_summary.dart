import 'package:flutter/material.dart';
import 'package:modulor_app/models/enums/currency.dart';

import '../../constants/colors.dart';
import '../../models/price.dart';

class OrderSummaryRetrieval extends StatelessWidget {
  final Price totalPrice;

  const OrderSummaryRetrieval({super.key, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(11),
        ),
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Order Summary",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 20,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Nett amount"),
                        Text(
                            "${(totalPrice.price - (totalPrice.price * 0.07)).toStringAsFixed(2)}${totalPrice.currency.value}")
                      ],
                    ),
                    Divider(color: AppColor.backgroundGrey,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("VAT (7%)"),
                        Text(
                            "${((totalPrice.price * 0.07)).toStringAsFixed(2)}${totalPrice.currency.value}")
                      ],
                    ),
                    Divider(color: AppColor.backgroundGrey,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total amount"),
                        Text(
                            "${(totalPrice.price).toStringAsFixed(2)}${totalPrice.currency.value}")
                      ],
                    )
                  ],
                ),
              ],
            )));
  }
}
