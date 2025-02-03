import 'dart:math';
import 'dart:ui';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../models/price.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final Price price;
  final VoidCallback onAddToCart;
  final String description;


  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.onAddToCart,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      borderOnForeground: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image

          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(11),
              bottom: Radius.circular(11),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                double imageHeight = constraints.maxHeight > 250 ? 250 : constraints.maxHeight;

                return Stack(
                  children: [
                    Image.network(
                      imageUrl,
                      fit: BoxFit.fitWidth,
                      width: double.infinity,
                      height: imageHeight,
                    ),
                    Positioned.fill(
                      child: Container(
                        color: Colors.black.withOpacity(0.04),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),



          // Product Title
          Padding(
            padding: const EdgeInsets.only(left: 0.0, right: 0.0, top: 1.0),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 3),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              decoration: BoxDecoration(
                color: AppColor.backgroundGrey,
              ),
              child: const Text(
                "21 x 29,7 cm",
                style: TextStyle(fontSize: 13, color: AppColor.paragraphBlack, letterSpacing: -0.52),
              ),
            ),
          ),

          const SizedBox(height: 4),

          // Pricing Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Baseline(
              baseline: 20, // The baseline value (usually the font size of the larger text)
              baselineType: TextBaseline.alphabetic, // Use alphabetic baseline for text
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${price.toStringAsFixed(2)}€",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      letterSpacing: -0.83,
                    ),
                  ),
                  SizedBox(width: 4),
    Transform.translate(
    offset: Offset(0, 1.8),
    child:
                  Text(
                    "${price.toStringAsFixed(2)}€",
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColor.paragraphBlack,
                      letterSpacing: -0.52,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
    )
                ],
              ),
            ),
          ),

          const SizedBox(height: 5),

          // Add to Basket Button
    SizedBox(
    width: double.infinity, // Take as much horizontal space as possible
    child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 0),
    child: ElevatedButton(
    style: ElevatedButton.styleFrom(
    backgroundColor: AppColor.modulorRed,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(30),
    ),
    padding: const EdgeInsets.symmetric(vertical: 0),
    ),
    onPressed: onAddToCart,
    child: const Text(
    "Add to basket",
    style: TextStyle(fontSize: 16, color: Colors.white, letterSpacing: -0.62),
    ),
    ),
    ),
    ),

        ],
      ),
    );
  }
}
