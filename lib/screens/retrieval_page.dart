import 'package:flutter/material.dart';
import 'package:modulor_app/components/retrieval_page_components/order_summary.dart';
import 'package:modulor_app/components/retrieval_page_components/qr_code.dart';
import 'package:provider/provider.dart';

import '../components/order_confirmation_components/order_confirmation_item_list.dart';
import '../components/order_confirmation_components/payment_method.dart';
import '../components/order_confirmation_components/top_bar.dart';
import '../components/pickup_location/pickup_location.dart';
import '../constants/colors.dart';
import '../providers/cart_provider.dart';

class RetrievalPage extends StatelessWidget{
  const RetrievalPage({super.key});


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
                        child: TopBar(value: 'Order #${order.orderIdShort}',),
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              PickUpLocation(),
                              const SizedBox(height: 12),
                              QrCode(id: order.orderId),
                              const SizedBox(height: 12),
                              PaymentMethod(),
                              const SizedBox(height: 12),
                              OrderSummaryRetrieval(totalPrice: order.totalPrice),
                              const SizedBox(height: 12),

                              OrderConfirmationItemList(
                                items: order.items,
                                changeAmount: order.changeAmount,
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Align(
                      //   alignment: Alignment.bottomCenter,
                      //   child: PayButtonBlock(totalPrice: order.totalPrice),
                      // ),
                    ],
                  ),
                ),
              ));
        });
  }
}