import 'package:flutter/material.dart';
import '../../models/item.dart';
import 'cart_item.dart';


class CartList extends StatelessWidget {
  final List<Item> items;
  final void Function(String id, num newAmount) changeAmount;

  const CartList({super.key, required this.items, required this.changeAmount});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: items.isNotEmpty ? size.height / 3 : size.height/2,
      width: size.width,
      child: items.isNotEmpty
          ? ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final Item item = items[index];
          return CartItemNew(changeAmount: changeAmount, item: item);
        },
      )
          : const Center(
        child: Text("Your Cart is Empty",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromRGBO(0, 0, 0, 0.15),
              fontWeight: FontWeight.w500,
              fontSize: 35,
            )),
      ),
    );
  }
}
