import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class FeaturedCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: SingleChildScrollView(
          scrollDirection:
              Axis.horizontal,
          child: Row(
            children: List.generate(
              5,
              (index) => SizedBox(
                width: 130,
                height: 180,
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 2.5, vertical: 5),
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
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
