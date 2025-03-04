import 'package:flutter/material.dart';
import 'package:modulor_app/components/retrieval_page_components/order_summary.dart';
import 'package:modulor_app/components/retrieval_page_components/qr_code.dart';
import 'package:modulor_app/providers/pick_up_provider.dart';
import 'package:provider/provider.dart';

import '../components/order_confirmation_components/order_confirmation_item_list.dart';
import '../components/order_confirmation_components/payment_method.dart';
import '../components/order_confirmation_components/top_bar.dart';
import '../components/pickup_location/pickup_location.dart';
import '../constants/colors.dart';
import '../providers/app_provider.dart';
import '../providers/cart_provider.dart';

class RetrievalPage extends StatefulWidget {
  const RetrievalPage({super.key});

  @override
  State<StatefulWidget> createState() => _RetrievalPage();
}
class _RetrievalPage extends State<RetrievalPage>{
  @override
  Widget build(BuildContext context) {

    var order = Provider.of<CartProvider>(context, listen: false).order;
    var shortOrderId = Provider.of<CartProvider>(context, listen: false).orderIdShort;
    var items = Provider.of<CartProvider>(context, listen: false).items;
    var changeAmount = Provider.of<CartProvider>(context, listen: false).changeAmount;
    var api = Provider.of<AppProvider>(context, listen: false).apiUrl;

    Provider.of<AppProvider>(context, listen: false).jwt.then((val){
      Provider.of<PickUpProvider>(context, listen:false).createPickUpProcess(val, api, order.id);});





    return Consumer<PickUpProvider>(
        builder: (BuildContext context, PickUpProvider pickUp, Widget? child) {
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
                        child: TopBar(value: 'Order #$shortOrderId',),
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              PickUpLocation(),
                              const SizedBox(height: 12),
                              QrCode(id: pickUp.pickupId),
                              const SizedBox(height: 12),
                              PaymentMethod(),
                              const SizedBox(height: 12),
                              OrderSummaryRetrieval(totalPrice: order.totalPrice),
                              const SizedBox(height: 12),

                              OrderConfirmationItemList(
                                items: items,
                                changeAmount: changeAmount,
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