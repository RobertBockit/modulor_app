import 'package:flutter/material.dart';
import 'package:modulor_app/components/order_confirmation_components/order_confirmation_item.dart';

import '../../models/item.dart';
import 'collection_page_item.dart';

class CollectionPageProductList extends StatelessWidget {
  final List<Item> items;

  const CollectionPageProductList(
      {super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      // color: Colors.white,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(11),
        ),
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            child:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "Items",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              Container(
                  constraints: BoxConstraints(
                    maxHeight: double.infinity,
                  ),
                  // height: items.isNotEmpty ? size.height / size.height - items.length : size.height / 2,
                  width: double.infinity,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final Item item = items[index];
                      return CollectionPageItem(
                           item: item);
                    },
                  ))
            ])));
  }
}
