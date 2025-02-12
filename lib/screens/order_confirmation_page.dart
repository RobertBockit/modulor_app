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
          body: SafeArea(
        left: false,
        right: false,
        child: Container(
          color: AppColor.backgroundGrey, // Set the background color to grey
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: TopBar(value: "Order Confirmation"),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      PickUpLocation(),
                      const SizedBox(height: 12),
                      PaymentMethod(),
                      const SizedBox(height: 12),
                      OrderConfirmationItemList(
                        items: order.items,
                        changeAmount: order.changeAmount,
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: PayButtonBlock(totalPrice: order.totalPrice),
              ),
            ],
          ),
        ),
      ));
    });
  }
}
