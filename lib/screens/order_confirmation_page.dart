import 'package:flutter/material.dart';
import 'package:modulor_app/components/order_confirmation_components/order_confirmation_item_list.dart';
import 'package:modulor_app/components/order_confirmation_components/pay_button_block.dart';
import 'package:modulor_app/components/order_confirmation_components/payment_method.dart';
import 'package:modulor_app/components/order_confirmation_components/top_bar.dart';
import 'package:modulor_app/components/pickup_location/pickup_location.dart';
import 'package:modulor_app/providers/cart_provider.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';

class OrderConfirmationPage extends StatefulWidget {
  const OrderConfirmationPage({super.key});

  @override
  State<StatefulWidget> createState() => _OrderConfirmationPageState();
}

class _OrderConfirmationPageState extends State<OrderConfirmationPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
        builder: (BuildContext context, CartProvider order, Widget? child) {
      return Scaffold(

          backgroundColor: AppColor.backgroundGrey,
          body: SafeArea(
              left: false,
              right: false,
              child: Column(children: [
                Align(
                    alignment: Alignment.topCenter,
                    child: // you textField,
                    TopBar()),
                const SizedBox(height: 12),
                Expanded(child: SingleChildScrollView(child: Column(children: [
                PickUpLocation(),
                const SizedBox(height: 12),
                PaymentMethod(),
                const SizedBox(height: 12),
                OrderConfirmationItemList(
                    items: order.items, changeAmount: order.changeAmount),
                ]))),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: // you textField,
                        PayButtonBlock(totalPrice: order.totalPrice))
              ]
                  // return Padding(padding: const EdgeInsets.only(top: 26, bottom: 26, right: 10, left: 10),
                  //
                  // child: Text(""),);

                  )));
    });
  }
}
