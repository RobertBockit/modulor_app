import 'package:flutter/material.dart';
import '../components/top_menu/top_menu.dart';
import '../components/category_grid/category_grid.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();

    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: CategoryGrid(),
          ),
        ),
      ],
    );
  }
}
