import 'package:flutter/material.dart';
import 'package:modulor_app/models/enums/order_status.dart';
import '../../constants/colors.dart';
import '../../models/order_item.dart';

class OrderListItem extends StatelessWidget {
  final OrderItem item;

  const OrderListItem(
      {super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(11),
                child: Image.network(
                  "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/480px-No_image_available.svg.png",
                  height: 64,
                  width: 64,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.04),
                    borderRadius: BorderRadius.circular(
                        11),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(width: 20),
          Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Transform.translate(
                        offset: const Offset(0, 5),
                        child: Text(
                          item.orderStatus.value.value,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: item.orderStatus.value.color,

                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Order from: ${item.date}",
                          style: const TextStyle(
                            fontSize: 20,
                            height: -0,
                            letterSpacing: -0.5,
                            fontWeight: FontWeight.w400,
                          ),
                        ),

                        Row(
                          children: [
                            Text(
                              'Items: ${item.amountOfItem}',
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
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
