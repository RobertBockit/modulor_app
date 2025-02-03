import 'package:flutter/material.dart';
import '../../models/item.dart';

class CartItemNew extends StatelessWidget {
  final void Function(String id, num newAmount) changeAmount;
  final Item item;

  const CartItemNew(
      {super.key, required this.changeAmount, required this.item});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 108,
        maxWidth: MediaQuery.sizeOf(context).width,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "lib/assets/loading.gif",
            height: 64,
            width: 64,
          ),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 157),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.productName,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Text(
                    "Alpha: 1 | Betta: 3 | Gamma: 3",
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Text(
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14),
                        "${item.productPrice.price} "),
                    Text(
                        style: const TextStyle(
                            color: Color.fromARGB(255, 255, 73, 8),
                            fontSize: 14),
                        item.productPrice.currency.name),
                    const Text(
                        style: TextStyle(
                            fontWeight: FontWeight.w200, fontSize: 14),
                        "per unit")
                  ]),
                ]),
          ),
          SizedBox(
              width: 100,
              child: DecoratedBox(
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 0.5, color: Color.fromRGBO(0, 0, 0, 0.5))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        child: const SizedBox(
                          width: 30,
                          height: 30,
                          child: Center(
                            child: Text(
                              "-",
                            ),
                          ),
                        ),
                        onTap: () =>
                            changeAmount(item.productId, item.amount - 1),
                      ),
                      Text(
                          style: const TextStyle(
                              color: Color.fromARGB(255, 255, 73, 8),
                              fontSize: 22),
                          '${item.amount}'),
                      GestureDetector(
                        child: const SizedBox(
                          width: 30,
                          height: 30,
                          child: Center(
                            child: Text(
                              "+",
                            ),
                          ),
                        ),
                        onTap: () =>
                            changeAmount(item.productId, item.amount + 1),
                      ),
                    ],
                  )))
        ],
      ),
    );
  }
}
