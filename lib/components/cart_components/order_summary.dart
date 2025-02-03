import 'package:flutter/material.dart';
import '../../models/price.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary(
      {super.key, required this.totalPrice, required this.totalItems});

  final Price totalPrice;
  final num totalItems;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(boxShadow: [
          BoxShadow(
            blurRadius: 20,
            blurStyle: BlurStyle.normal,
            color: Color.fromRGBO(12, 24, 35, 0.12),
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ]),
        child: Card(
            color: const Color.fromARGB(255, 255, 255, 255),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 255, 73, 8),
                                    fontSize: 16),
                                "$totalItems "),
                            const Text("items")
                          ],
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                  "${totalPrice.price.toStringAsFixed(2)} "),
                              Text(
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 255, 73, 8),
                                      fontSize: 16),
                                  totalPrice.currency.name)
                            ])
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 73, 8),
                                    fontSize: 16),
                                "Back to store")),
                        ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 255, 73, 8),
                            ),
                            child: const Text(
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 16),
                                "Checkout"))
                      ],
                    )
                  ],
                ))));
  }
}
