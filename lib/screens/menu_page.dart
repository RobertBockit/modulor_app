import 'package:flutter/material.dart';
import 'package:modulor_app/components/category_grid/category_grid.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 170),
      child: Column(
        children: [
          Text(
            "Shop by Category",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.2,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: CategoryGrid(),
            ),
          ),
        ],
      ),
    );
  }
}
