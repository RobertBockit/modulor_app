import 'package:flutter/material.dart';
import 'package:modulor_app/components/product_card/checkbox.dart';
import 'package:modulor_app/models/enums/currency.dart';
import '../../constants/colors.dart';
import '../../models/item.dart';

class CartItemNew extends StatefulWidget {
  final void Function(String id, num newAmount) changeAmount;
  final void Function(String id, bool isSelected) toggleIsSelected;
  final Item item;

  const CartItemNew({
    super.key,
    required this.changeAmount,
    required this.toggleIsSelected,
    required this.item,
  });

  @override
  _CartItemNewState createState() => _CartItemNewState();
}

class _CartItemNewState extends State<CartItemNew> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ToggleCheckBox(
            itemId: widget.item.productId,
            toggleIsSelected: widget.toggleIsSelected,
            isChecked: widget.item.isSelected,
          ),
          const SizedBox(width: 20),
          _buildProductImage(),
          const SizedBox(width: 20),
          _buildProductDetails(),
        ],
      ),
    );
  }

  Widget _buildProductImage() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(11),
          child: Image.network(
            widget.item.productIcon,
            height: 64,
            width: 64,
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.04),
              borderRadius: BorderRadius.circular(11),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProductDetails() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Transform.translate(
            offset: const Offset(0, 5),
            child: Text(
              widget.item.productName,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${widget.item.productPrice.price.toStringAsFixed(2)} ${widget.item.productPrice.currency.value}",
                style: const TextStyle(
                  fontSize: 20,
                  letterSpacing: -0.5,
                  fontWeight: FontWeight.w400,
                ),
              ),
              _buildQuantitySelector(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuantitySelector() {
    return Row(
      children: [
        _buildQuantityButton(Icons.remove, widget.item.amount - 1),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            '${widget.item.amount}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
        ),
        _buildQuantityButton(Icons.add, widget.item.amount + 1),
      ],
    );
  }

  Widget _buildQuantityButton(IconData icon, num newAmount) {
    return GestureDetector(
      onTap: () => widget.changeAmount(widget.item.productId, newAmount),
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(241, 243, 244, 1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 16, color: AppColor.paragraphBlack),
      ),
    );
  }
}
