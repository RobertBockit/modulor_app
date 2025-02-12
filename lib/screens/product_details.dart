import 'package:flutter/material.dart';
import '../components/navbar/navbar.dart';
import '../components/product_card/carrousel_image_product.dart';
import '../components/product_card/similar_products_row.dart';
import '../constants/colors.dart';

class ProductDetailsPage extends StatelessWidget {
  final String title;
  final String imageUrl;
  final double price;
  final VoidCallback onAddToCart;

  const ProductDetailsPage({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundGrey,
      body: Stack(
        children: [
          SafeArea(
            left: false,
            right: false,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CarouselWithIndicatorDemo(),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Kopierpapier HP Office',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 2),
                          decoration:
                              BoxDecoration(color: AppColor.backgroundGrey),
                          child: const Text(
                            "80 g/m², 210 x 297 DIN A4 (SB), 500 Blatt",
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColor.paragraphBlack,
                              letterSpacing: -0.52,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "19,99€",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                                letterSpacing: -0.83,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Transform.translate(
                              offset: const Offset(0, 1.8),
                              child: Text(
                                "24,99€",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColor.paragraphBlack,
                                  letterSpacing: -0.52,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ),
                            const SizedBox(width: 4),
                            Transform.translate(
                              offset: const Offset(0, 1.8),
                              child: Text(
                                "(1.39€/m^2)",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColor.paragraphBlack,
                                  letterSpacing: -0.52,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Only 1 item left in stock!',
                          style: TextStyle(
                              fontSize: 13,
                              color: AppColor.modulorRed,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Hochweiß, matt, holzfrei, alterungsbeständig, weitgehend chlorfrei gebleicht, ColorLok, Standardpapier für Kopierer, Laserdrucker, Ink-Jet-Drucker (Schwarz-Linien) und Normalpapier-Fax',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 10),
                        const Divider(
                          thickness: 1, // Line width
                          color: AppColor.backgroundGrey, // Line color
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Similar Items',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                        similarProductsSection(),
                        const SizedBox(
                            height:
                                80), // Extra space so content doesn't get hidden under button
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 60,
            left: 20,
            child: InkWell(
              onTap: () {
                Navigator.pop(context); // Navigate back
              },
              borderRadius: BorderRadius.circular(50),
              child: Container(
                width: 50, // Ensures a perfect circle
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(Icons.arrow_back_ios_new),
              ),
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: ElevatedButton(
              onPressed: () {
                onAddToCart();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.modulorRed,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                'Add to Cart',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(), // Navbar remains fixed
    );
  }
}
