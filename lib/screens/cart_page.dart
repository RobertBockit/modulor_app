import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modulor_app/components/cart_components/select_all_checkbox.dart';
import 'package:provider/provider.dart';
import '../components/cart_components/cart_list.dart';
import '../constants/colors.dart';
import '../providers/cart_provider.dart';
import 'order_confirmation_page.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (BuildContext context, CartProvider order, Widget? child) {
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SelectAllCheckbox(
                              isChecked: order.areAllItemsSelected,
                              onTap: (isSelected) {
                                order.toggleAllSelected(isSelected);
                              },
                            ),
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
                          color: const Color.fromRGBO(164, 164, 164, 1),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Consumer<CartProvider>(
                      builder: (context, order, child) {
                        return CartList(
                          items: order.items,
                          changeAmount: order.changeAmount,
                          toggleIsSelected: order.toggleIsSelected,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Material(
                elevation: 8,
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