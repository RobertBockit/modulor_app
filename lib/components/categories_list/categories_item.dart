import 'package:flutter/material.dart';

class CategoriesItem extends StatelessWidget {
  final String imagePath;
  final String label;

  const CategoriesItem({super.key, required this.imagePath, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey.shade200,
            ),
            clipBehavior: Clip.hardEdge,
            child: Stack(
              children: [
                Image.network(
                  imagePath,
                  fit: BoxFit.cover,
                  width: 80,
                  height: 80,
                ),
                Container(
                  width: 80,
                  height: 80,
                  color: Colors.black.withOpacity(0.04),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
