import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import '../../constants/colors.dart';
import '../../models/price.dart';

class ProductCard extends StatefulWidget {
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
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  // Start with a default height of 180 pixels.
  double _containerHeight = 180.0;

  @override
  void initState() {
    super.initState();
    _fetchImageDimensions();
  }

  /// Downloads the image, decodes it, and computes a target container height.
  ///
  /// The height is determined by calculating the image’s aspect ratio (height/width)
  /// and then linearly interpolating the container height between:
  ///   - 180 px when ratio ≤ 1 (square or wide image)
  ///   - 300 px when ratio ≥ 2 (very tall image)
  /// For ratios in between, the height is scaled continuously.
  Future<void> _fetchImageDimensions() async {
    try {
      final response = await http.get(Uri.parse(widget.imageUrl));
      if (response.statusCode == 200) {
        final Uint8List bytes = response.bodyBytes;
        final decodedImage = img.decodeImage(bytes);
        if (decodedImage != null) {
          final int imageWidth = decodedImage.width;
          final int imageHeight = decodedImage.height;
          final double ratio = imageHeight / imageWidth;
          double newHeight;

          if (ratio <= 1) {
            newHeight = 180.0;
          } else if (ratio >= 2) {
            newHeight = 300.0;
          } else {
            // Linear interpolation between 180 and 300.
            // When ratio == 1, height = 180; when ratio == 2, height = 300.
            newHeight = 180.0 + (ratio - 1.0) * 120.0;
          }

          // Update the state only if the computed height is different.
          if (mounted && _containerHeight != newHeight) {
            setState(() {
              _containerHeight = newHeight;
            });
          }
        }
      }
    } catch (e) {
      print('Error fetching image dimensions: $e');
    }
  }

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
          // Product Image Container
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(11),
              bottom: Radius.circular(11),
            ),
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: _containerHeight,
                  color: Colors.black.withOpacity(0.04),
                  child: Image.network(
                    widget.imageUrl,
                    // Use BoxFit.contain to ensure the whole image is shown,
                    // which might leave a gap on the sides if the image is tall.
                    fit: BoxFit.contain,
                    width: double.infinity,
                    height: _containerHeight,
                  ),
                ),
                // A subtle overlay (if desired)
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withOpacity(0.04),
                  ),
                ),
              ],
            ),
          ),

          // Product Title
          Padding(
            padding: const EdgeInsets.only(left: 0.0, right: 0.0, top: 1.0),
            child: Text(
              widget.title,
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

          // Additional Product Info Container
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              decoration: BoxDecoration(
                color: AppColor.backgroundGrey,
              ),
              child: const Text(
                "21 x 29,7 cm",
                style: TextStyle(
                    fontSize: 13,
                    color: AppColor.paragraphBlack,
                    letterSpacing: -0.52),
              ),
            ),
          ),
          const SizedBox(height: 4),

          // Pricing Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Baseline(
              baseline: 20,
              baselineType: TextBaseline.alphabetic,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${widget.price.toStringAsFixed(2)}€",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      letterSpacing: -0.83,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Transform.translate(
                    offset: const Offset(0, 1.8),
                    child: Text(
                      "${widget.price.toStringAsFixed(2)}€",
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColor.paragraphBlack,
                        letterSpacing: -0.52,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 5),

          // Add to Basket Button
          SizedBox(
            width: double.infinity,
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
                onPressed: widget.onAddToCart,
                child: const Text(
                  "Add to basket",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      letterSpacing: -0.62),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
