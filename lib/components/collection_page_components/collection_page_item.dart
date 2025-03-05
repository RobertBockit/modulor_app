import 'package:flutter/material.dart';
import 'package:modulor_app/models/enums/currency.dart';
import '../../models/item.dart';

class CollectionPageItem extends StatelessWidget {
  final Item item;

  const CollectionPageItem({required this.item});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Product Image Column
          Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(11),
                child: Image.network(
                  item.productIcon,
                  height: 64,
                  width: 64,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),

          const SizedBox(width: 20),

          // Title and Price Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.productName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "${item.productPrice.price.toStringAsFixed(2)} ${item.productPrice.currency.value}",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 10,),

          // Amount Column
          Column(
            children: [
              Text(
                'Take ${item.amount} item',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
