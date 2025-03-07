import 'package:flutter/material.dart';

class similarProductsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right:20),
            child: ProductCard(),
          );
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(11),
                child: Image.network(
                  'https://cdn.modulor.de/products/dxzk9_3015186-st/1_1920_1920_r_soulbottle_trinkflasche_mit_tragegriff_edelstahl_schillernd_0_5_l_bugelverschluss_utopia_light.jpg',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(11),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            "Product Title",
            style: TextStyle(fontSize: 14),
            overflow: TextOverflow.ellipsis,
          ),
          const Text(
            "\19.99€",
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              minimumSize: const Size(100, 36),
            ),
            child: const Text("Add to Cart",
            style: TextStyle(
              color: Colors.white
            ),),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
      home: Scaffold(body: Center(child: similarProductsSection()))));
}
