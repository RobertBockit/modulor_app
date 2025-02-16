import 'package:flutter/material.dart';
import 'categories_item.dart';
class CategoriesRow extends StatelessWidget {
  const CategoriesRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: const [
                CategoriesItem(imagePath: 'assets/stäbe.png', label: 'Stäbe'),
                CategoriesItem(imagePath: 'assets/formenbau.png', label: 'Formenbau'),
                CategoriesItem(imagePath: 'assets/modelfiguren.png', label: 'Modelfiguren'),
                CategoriesItem(imagePath: 'assets/werkzeug.png', label: 'Werkzeug'),
                CategoriesItem(imagePath: 'assets/werkzeug.png', label: 'Werkzeug'),
                CategoriesItem(imagePath: 'assets/werkzeug.png', label: 'Werkzeug'),

              ],
            ),
          ),
    );
    }
}