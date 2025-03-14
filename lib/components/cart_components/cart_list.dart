import 'package:flutter/material.dart';
import '../../models/item.dart';
import 'cart_item.dart';

class CartList extends StatelessWidget {
  final List<Item> items;
  final void Function(String id, num newAmount) changeAmount;
  final void Function(String id, bool isSelected) toggleIsSelected;

  const CartList({super.key, required this.items, required this.changeAmount, required this.toggleIsSelected});

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Container(child: SizedBox(
      width: size.width,
      child: items.isNotEmpty
          ? ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final Item item = items[index];
          return CartItemNew(changeAmount: changeAmount, item: item, toggleIsSelected: toggleIsSelected);
        },
      )
          : const Center(
        child: Text("",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromRGBO(0, 0, 0, 0.15),
              fontWeight: FontWeight.w500,
              fontSize: 35,
            )),
      ),
    ));
  }
}
