import 'dart:ui';

import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class AddToCartButtonProductDetails extends StatefulWidget {
  final VoidCallback onAddToCart;
  final int quantity;

  const AddToCartButtonProductDetails(
      {super.key, required this.onAddToCart, required this.quantity});

  @override
  _AddToCartButtonState createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButtonProductDetails> {
  bool _isDisabled = false;

  void _handlePress() {
    if (_isDisabled) return;

    setState(() {
      _isDisabled = true;
    });

    for (var i = 0; i < widget.quantity; i++) {
      widget.onAddToCart();
    }

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isDisabled = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _isDisabled ? () {} : _handlePress,
      style: ElevatedButton.styleFrom(
        backgroundColor: _isDisabled
            ? AppColor.modulorRed.withOpacity(0.7)
            : AppColor.modulorRed,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(11),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: Text(
        _isDisabled ? "Added to cart" : "Add to Cart",
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}
