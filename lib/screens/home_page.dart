import 'package:flutter/material.dart';
import 'package:modulor_app/components/featured_categories/featured_categories.dart';
import 'package:modulor_app/components/home_screen_poster/home_screen_poster.dart';
import 'package:modulor_app/components/product_card/product_card.dart';
import 'package:modulor_app/screens/product_details.dart';

import '../components/top_menu/top_menu.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 100),

          SafeArea(
            child: Stack(
              children: [
                HomeScreenPoster(),
                Positioned(
                  top: 210,
                  left: 0,
                  right: 0,
                  child: FeaturedCategories(),
                ),
              ],
            ),
          ),
          SizedBox(height: 5,),
          Text(" Available Items",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.2,
            ),
          ),
          SizedBox(height: 5,),
          Column(
            children: List.generate(5, (index) => ProductCard()),
          ),
          Text(" Recommended for you",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.2,
            ),
          ),
          SizedBox(height: 5,),
          Column(
            children: List.generate(5, (index) => ProductCard()),
          ),
          Text(" Discounted Items",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.2,
            ),
          ),
          SizedBox(height: 5,),
      Column(
        children: List.generate(15, (index) {
          return GestureDetector(
            onTap: () {
              _navigateToProductDetails(context);
            },
            child: ProductCard(), // The card remains decoupled from logic
          );
        }
        ),)
        ],
      ),
    );
  }
  void _navigateToProductDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailsPage(
        ),
      ),
    );
  }
}
