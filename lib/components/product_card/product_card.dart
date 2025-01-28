import 'package:flutter/material.dart';
import 'package:modulor_app/models/enums/currency.dart';
import '../../constants/colors.dart';
import '../../models/price.dart';
import '../../models/product.dart';
import '../../screens/product_details.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final Price price;
  final VoidCallback onAddToCart;

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.price,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    final double rating = 4.02;
    final int reviewsCount = 192;
    final String salesInfo = "400+ bought last year";
    final int starAmount = rating ~/ 1;
    final String stars = "★" * starAmount + "☆" * (5 - starAmount);

    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 173, // Minimum height is always 173
      ),
      child: IntrinsicHeight(
        child: Container(
          margin: EdgeInsets.only(left: 5.0, top: 2.5, right: 5.0, bottom: 2.5),
          color: AppColor.backgroundGrey,
          width: double.infinity,
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  child: Image.network(
                    imageUrl, // Dynamically passed imageUrl
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  padding: EdgeInsets.only(
                      left: 5.0, right: 5.0, top: 15.0, bottom: 15.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColor.backgroundGrey),
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title, // Dynamically passed title
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: AppColor.paragraphBlack,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            height: 1.2),
                      ),
                      SizedBox(height: 3),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 3, vertical: 1), // Adjust padding for pill shape
                        decoration: BoxDecoration(
                          color: AppColor.backgroundGrey, // Background color of the pill
                          border: Border.all(color: Colors.white), // Border color same as the background
                        ),
                        child: Text(
                          "Product Tag", // Fixed tag text
                          style: TextStyle(
                            color: AppColor.paragraphBlack,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("$rating"),
                              Text(
                                " $stars ",
                                style: TextStyle(color: AppColor.ratingOrange),
                              ),
                              Text("($reviewsCount reviews)"),
                            ],
                          ),
                          Transform.translate(
                            offset: Offset(0, -5),
                            child: Text(
                              salesInfo,
                              style: TextStyle(color: AppColor.paragraphGrey),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Text(
                            "${price.toStringAsFixed(2)}€", // Dynamically passed price
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            " (${(1 / 10).toStringAsFixed(2)}€ / pcs.)", // Example per-unit calculation
                            style: TextStyle(
                                fontSize: 14, color: AppColor.paragraphGrey),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 34.0,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all<Color>(
                                  AppColor.modulorRed),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                ),
                              )),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailsPage(), // Navigate to product details
                              ),
                            );
                          },
                          child: Text(
                            "Buy Now",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
