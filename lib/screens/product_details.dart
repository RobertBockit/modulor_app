import 'package:flutter/material.dart';
import '../components/add_to_cart_button/AddToCartButtonProductDetails.dart';
import '../components/navbar/navbar.dart';
import '../components/product_card/carrousel_image_product.dart';
import '../components/product_card/similar_products_row.dart';
import '../constants/colors.dart';

class ProductDetailsPage extends StatefulWidget {
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
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int _quantity = 1;

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

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
                  CarouselWithIndicatorDemo(imageUrl: widget.imageUrl,),
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
                          widget.title,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 2),
                          decoration:
                              BoxDecoration(color: AppColor.backgroundGrey),
                          child: const Text(
                            "Very Qualitative Materials",
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
                              widget.price.toStringAsFixed(2),
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
                                (widget.price + 5).toStringAsFixed(2),
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
                                "(1.39€/piece)",
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
                        Transform.translate(
                          offset: Offset(-10, 0),
                          child: Row(
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(241, 243, 244,
                                          1),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.remove,
                                        size: 16,
                                        color: AppColor.paragraphBlack),
                                    onPressed: () => _decrementQuantity(),
                                  ),
                                ],
                              ),
                              Text(
                                '$_quantity',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: -0.5,
                                ),
                              ),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(241, 243, 244, 1),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add,
                                        size: 16,
                                        color: AppColor.paragraphBlack),
                                    onPressed: () => _incrementQuantity(),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),

                        Text(
                          'Hochweiß, matt, holzfrei, alterungsbeständig, weitgehend chlorfrei gebleicht, ColorLok, Standardpapier für Kopierer, Laserdrucker, Ink-Jet-Drucker (Schwarz-Linien) und Normalpapier-Fax',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 10),
                        const Divider(
                          thickness: 1,
                          color: AppColor.backgroundGrey,
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
                                80),
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
                Navigator.pop(context);
              },
              borderRadius: BorderRadius.circular(50),
              child: Container(
                width: 50,
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
            child: AddToCartButtonProductDetails(onAddToCart: () {  widget.onAddToCart(); }, quantity: _quantity,),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
