import 'package:flutter/material.dart';
import 'package:modulor_app/components/collection_page_components/collection_page_product_list.dart';
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

class CollectionScreen extends StatefulWidget {
  const CollectionScreen({super.key});

  @override
  State<StatefulWidget> createState() => _RetrievalPage();
}

class _RetrievalPage extends State<CollectionScreen> {
  @override
  Widget build(BuildContext context) {
    var order = Provider.of<CartProvider>(context, listen: false).order;
    var shortOrderId =
        Provider.of<CartProvider>(context, listen: false).orderIdShort;
    var items = Provider.of<CartProvider>(context, listen: false).items;
    var changeAmount =
        Provider.of<CartProvider>(context, listen: false).changeAmount;
    var api = Provider.of<AppProvider>(context, listen: false).apiUrl;

    Provider.of<AppProvider>(context, listen: false).jwt.then((val) {
      Provider.of<PickUpProvider>(context, listen: false)
          .createPickUpProcess(val, api, order.id);
    });

    var text = "Order in Collection | Please take items from the locker";
    var isOrderFinished = false;
    var textColor = isOrderFinished == true
        ? Color.fromRGBO(32, 160, 7, 1)
        : Color.fromRGBO(238, 120, 10, 1);
    void checkOrderRepeatedly(String jwt, String api) async {
      while (mounted) {
        await Future.delayed(Duration(seconds: 3)); // Poll every 3 seconds

        var pickUpProvider =
            Provider.of<PickUpProvider>(context, listen: false);

        try {
          await pickUpProvider.checkPickUpProgress(jwt, api);
          if (pickUpProvider.pickUpStatus == "finished") {
            isOrderFinished = true;
            text = "Order Collected | You can close this page";
            break;
          }
        } catch (e) {}
      }
    }

    Provider.of<AppProvider>(context, listen: false).jwt.then((jwt) {
      var orderId = Provider.of<CartProvider>(context, listen: false).order.id;
      Provider.of<PickUpProvider>(context, listen: false)
          .createPickUpProcess(jwt, api, orderId);

      checkOrderRepeatedly(jwt, api);
    });

    return Consumer<PickUpProvider>(
        builder: (BuildContext context, PickUpProvider pickUp, Widget? child) {
      return Scaffold(
          body: SafeArea(
        left: false,
        right: false,
        child: Container(
          color: AppColor.backgroundGrey,
          // Set the background color to grey
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: TopBar(
                  value: 'Collecting Order #$shortOrderId',
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      PickUpLocation(),
                      const SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(11),
                        ),
                        child: Text(
                          text,
                          style: TextStyle(color: textColor),
                        ),
                      ),
                      const SizedBox(height: 12),
                      CollectionPageProductList(
                        items: items,
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
