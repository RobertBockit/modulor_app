import 'package:flutter/material.dart';
import 'package:modulor_app/components/profile_components/orders_list_item.dart';
import 'package:modulor_app/providers/profile_provider.dart';
import 'package:provider/provider.dart';

import '../../models/order_item.dart';

class OrdersList extends StatefulWidget {
  final bool isActive;

  const OrdersList({super.key, required this.isActive});

  @override
  State<OrdersList> createState() => _OrdersList();
}

class _OrdersList extends State<OrdersList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (BuildContext context, ProfileProvider profileProvider, Widget? child) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(11),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.isActive ? "Active orders" : "All orders",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                FutureBuilder<List<OrderItem>>(
                  future: widget.isActive ? profileProvider.activeOrders : profileProvider.allOrders,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: widget.isActive ? Text("No active orders") : Text("You don't have any orders"));
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final OrderItem item = snapshot.data![index];
                        return OrderListItem(item: item);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
