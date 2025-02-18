import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../components/cart_components/cart_list.dart';
import '../components/product_card/checkbox.dart';
import '../constants/colors.dart';
import '../providers/cart_provider.dart';
import 'order_confirmation_page.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<StatefulWidget> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    double topPadding = MediaQuery.of(context).padding.top + 0; // Adjusted for navbar

    return Consumer<CartProvider>(
      builder: (BuildContext context, CartProvider order, Widget? child) {
        return Stack(
          children: [
            // Main content without bottom padding so that the list scrolls under the button.
            Padding(
              padding: EdgeInsets.only(top: topPadding, left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [

                            const SizedBox(width: 20),
                            const Text(
                              "Select All",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        SvgPicture.asset(
                          'assets/icons/trash-2.svg',
                          width: 24,
                          height: 24,
                          color: Color.fromRGBO(164, 164, 164, 1),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Product List. (If needed, add padding inside CartList so items aren’t hidden behind the button.)
                  Expanded(
                    child: CartList(
                      items: order.items,
                      changeAmount: order.changeAmount,
                      toggleIsSelected: order.toggleIsSelected
                    ),
                  ),
                ],
              ),
            ),

            // Floating Checkout Button on top of the product list.
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Material(
                elevation: 8, // This gives a floating look
                borderRadius: BorderRadius.circular(11),
                child: ElevatedButton(
                  onPressed: () {
                    if (order.totalAmount != 0) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OrderConfirmationPage(),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: order.totalAmount != 0
                        ? AppColor.modulorRed
                        : AppColor.modulorRedDisabled,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    order.totalAmount != 0
                        ? 'Checkout ${order.totalAmount} ${order.totalAmount == 1 ? "item" : "items"} (${order.totalPrice.toStringAsFixed(2)}€)'
                        : 'Cart is empty, add items now!',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
