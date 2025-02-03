import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../models/price.dart';

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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 3,
      margin: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              height: 180,
              width: double.infinity,
            ),
          ),

          // Product Title
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // Size Label
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                "21 x 29,7 cm",
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Pricing Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Text(
                  "${price.toStringAsFixed(2)}€",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  "${price.toStringAsFixed(2)}€",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Add to Basket Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.modulorRed,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: onAddToCart,
              child: const Text(
                "Add to basket",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),

          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
