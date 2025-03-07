import 'dart:math';
import 'package:flutter/material.dart';
import 'package:modulor_app/components/add_to_cart_button/AddToCartButton.dart';
import 'package:provider/provider.dart';

import '../../constants/colors.dart';
import '../../models/item.dart';
import '../../models/price.dart';
import '../../providers/cart_provider.dart';
import '../../screens/product_details.dart';

class ProductCard extends StatefulWidget {
  final String productId;
  final String imageUrl;
  final String title;
  final Price price;
  final VoidCallback onAddToCart;
  final String description;

  const   ProductCard({
    Key? key,
    required this.productId,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.onAddToCart,
    required this.description,
  }) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  double _containerHeight = 180;
  late final NetworkImage _networkImage;
  ImageStream? _imageStream;
  late final ImageStreamListener _imageStreamListener;

  @override
  void initState() {
    super.initState();
    _networkImage = NetworkImage(widget.imageUrl);
    _attachImageListener();
  }


  void _attachImageListener() {
    final imageConfiguration = const ImageConfiguration();
    _imageStream = _networkImage.resolve(imageConfiguration);

    _imageStreamListener = ImageStreamListener(
          (ImageInfo imageInfo, bool synchronousCall) {
        if (!mounted) return;
        final image = imageInfo.image;
        _updateContainerHeight(image.width, image.height);
      },
      onError: (exception, stackTrace) {
        debugPrint("Image load failed: $exception");
      },
    );

    _imageStream?.addListener(_imageStreamListener);
  }


  void _updateContainerHeight(int imageWidth, int imageHeight) {
    double aspectRatio = imageWidth / imageHeight;

    double t = ((aspectRatio - 0.5) / (1.5 - 0.5)).clamp(0.0, 1.0);

    double newContainerHeight = 225 - (225 - 140) * t;

    if (mounted) {
      setState(() {
        _containerHeight = newContainerHeight;
      });
    }
  }

  @override
  void dispose() {
    _imageStream?.removeListener(_imageStreamListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsPage(
              title: widget.title,
              imageUrl: widget.imageUrl,
              price: widget.price.toDouble(),
              onAddToCart: () {
                Provider.of<CartProvider>(context, listen: false).addItem(
                  Item(
                    widget.productId,
                    widget.imageUrl,
                    widget.title,
                    widget.price,
                    true,
                  ),
                );
              },
            ),
          ),
        );
      },
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                    color: const Color.fromRGBO(0, 0, 0, 0.02),
                    child: Image(
                      image: _networkImage,
                      fit: BoxFit.contain,
                      width: double.infinity,
                      height: _containerHeight,
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      color: const Color.fromRGBO(0, 0, 0, 0.02),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 1.0),
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
                    letterSpacing: -0.52,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
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
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: AddToCartButton(onAddToCart: widget.onAddToCart)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
