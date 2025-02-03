import 'package:flutter/material.dart';

class CategoryGrid extends StatelessWidget {
  const CategoryGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 3 columns
        mainAxisSpacing: 10, // Vertical spacing between rows
        crossAxisSpacing: 10, // Horizontal spacing between columns
        childAspectRatio: 0.8, // Adjust the aspect ratio to your preference
      ),
      itemCount: 12, // Total number of grid items
      itemBuilder: (context, index) {
        return const CategoryItem();
      },
    );
  }
}

class CategoryItem extends StatelessWidget {
  const CategoryItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2.5, vertical: 5),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Category Name",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Image.network(
            "https://cdn.modulor.de/category/dd31e2a8593ba5a4566d8565aa5cc891_240_240.png",
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
