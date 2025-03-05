import 'package:flutter/material.dart';

import '../../constants/colors.dart';
class AddToCartButton extends StatefulWidget {
  final VoidCallback onAddToCart;

  const AddToCartButton({super.key, required this.onAddToCart});

  @override
  _AddToCartButtonState createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton> {
  bool _isDisabled = false;

  void _handlePress() {
    if (_isDisabled) return;

    setState(() {
      _isDisabled = true;
    });

    widget.onAddToCart();

    Future.delayed(const Duration(seconds: 4), () {
      setState(() {
        _isDisabled = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: _isDisabled ? AppColor.modulorRed.withOpacity(0.7) : AppColor.modulorRed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(vertical: 0),
      ),
      onPressed: _isDisabled ? () {} : _handlePress, // Keep onPressed defined to prevent default animation delay
      child: Text(
        _isDisabled ? "Added to cart" : "Add to basket",
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
          letterSpacing: -0.62,
        ),
      ),
    );
  }
}