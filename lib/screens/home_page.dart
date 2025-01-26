import 'package:flutter/material.dart';
import 'package:modulor_app/components/product_card/product_card.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [ProductCard(),],),
    );
  }
}
