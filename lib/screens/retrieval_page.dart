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
import 'collection_screen.dart';

class RetrievalPage extends StatefulWidget {
  const RetrievalPage({super.key});

  @override
  State<StatefulWidget> createState() => _RetrievalPageState();
}

class _RetrievalPageState extends State<RetrievalPage> {
  @override
  void initState() {
    super.initState();

    var api = Provider.of<AppProvider>(context, listen: false).apiUrl;

    Provider.of<AppProvider>(context, listen: false).jwt.then((jwt) {
      var orderId = Provider.of<CartProvider>(context, listen: false).order.id;
      Provider.of<PickUpProvider>(context, listen: false).createPickUpProcess(jwt, api, orderId);

      checkPickUpProgressRepeatedly(jwt, api);
    });
  }

  void checkPickUpProgressRepeatedly(String jwt, String api) async {
    while (mounted) {
      await Future.delayed(Duration(seconds: 3));

      var pickUpProvider = Provider.of<PickUpProvider>(context, listen: false);


      try {
        await pickUpProvider.checkPickUpProgress(jwt, api);

        if (pickUpProvider.pickUpStatus == "started") {

          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => CollectionScreen()),
            );
          }
          break;
        }
      } catch (e) {
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    var order = Provider.of<CartProvider>(context, listen: false).order;
    var shortOrderId = Provider.of<CartProvider>(context, listen: false).orderIdShort;
    var items = Provider.of<CartProvider>(context, listen: false).items;
    var changeAmount = Provider.of<CartProvider>(context, listen: false).changeAmount;

    return Consumer<PickUpProvider>(
      builder: (context, pickUp, child) {
        return Scaffold(
          body: SafeArea(
            left: false,
            right: false,
            child: Container(
              color: AppColor.backgroundGrey,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: TopBar(value: 'Order #$shortOrderId'),
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
