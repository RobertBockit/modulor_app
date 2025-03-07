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
                CategoriesItem(imagePath: 'https://cdn.modulor.de/products/caea/1_928_928_r_buche_rundstab.jpg', label: 'Stäbe'),
                CategoriesItem(imagePath: 'https://cdn.modulor.de/products/oaad/1_928_928_r_formenbau_plastilin.jpg', label: 'Formenbau'),
                CategoriesItem(imagePath: 'https://cdn.modulor.de/products/tlgp/1_928_928_r_preiser_detail_figuren_unbemalt_weiss_1_50.jpg', label: 'Modelfiguren'),
                CategoriesItem(imagePath: 'https://cdn.modulor.de/products/h9cgw/1_928_928_r_ecobra_schneidematte_top_qualitat_grun_schwarz.jpg', label: 'Werkzeug'),

              ],
            ),
          ),
    );
    }
}