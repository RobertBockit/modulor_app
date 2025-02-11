import 'package:flutter/material.dart';
import 'package:modulor_app/components/category_grid/category_grid.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 170),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 0,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(0.0),
              child: Container(
                child: CategoryGrid(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
