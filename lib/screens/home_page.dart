import 'package:flutter/material.dart';
import 'package:modulor_app/components/featured_categories/featured_categories.dart';
import 'package:modulor_app/components/home_screen_poster/home_screen_poster.dart';
import 'package:modulor_app/components/product_card/product_card.dart';

import '../components/top_menu/top_menu.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopMenu(),
          Stack(
            children: [
              HomeScreenPoster(),
              // Position the FeaturedCategories above the gap
              Positioned(
                top: 210, // Adjust this value as needed
                left: 0,
                right: 0,
                child: FeaturedCategories(),
              ),
            ],
          ),
          SizedBox(height: 5,),
          Text(" Available Items",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.2,
          ),),
          SizedBox(height: 5,),
          ProductCard(),
        ],
      ),
    );
  }
}
