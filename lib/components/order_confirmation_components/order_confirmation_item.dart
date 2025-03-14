import 'package:flutter/material.dart';
import 'package:modulor_app/components/product_card/checkbox.dart';
import 'package:modulor_app/models/enums/currency.dart';
import '../../constants/colors.dart';
import '../../models/item.dart';

class OrderConfirmationItem extends StatelessWidget {
  final void Function(String id, num newAmount) changeAmount;
  final Item item;

  const OrderConfirmationItem(
      {super.key, required this.changeAmount, required this.item});

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
                  item.productIcon,
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
                      item.productName,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${item.productPrice.price.toStringAsFixed(2)} ${item.productPrice.currency.value}",
                      style: const TextStyle(
                        fontSize: 20,
                        height: -0,
                        letterSpacing: -0.5,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    Row(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(241, 243, 244,
                                    1),
                                shape: BoxShape.circle,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.remove,
                                  size: 16, color: AppColor.paragraphBlack),
                              onPressed: () =>
                                  changeAmount(item.productId, item.amount - 1),
                            ),
                          ],
                        ),
                        Text(
                          '${item.amount}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            letterSpacing: -0.5,
                          ),
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(241, 243, 244,
                                    1),
                                shape: BoxShape.circle,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add,
                                  size: 16, color: AppColor.paragraphBlack),
                              onPressed: () =>
                                  changeAmount(item.productId, item.amount + 1),
                            ),
                          ],
                        )
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
