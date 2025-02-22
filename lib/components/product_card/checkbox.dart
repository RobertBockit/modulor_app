import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class ToggleCheckBox extends StatelessWidget {
  final String itemId;
  final bool isChecked;
  final void Function(String id, bool isSelected) toggleIsSelected;

  const ToggleCheckBox({
    Key? key,
    required this.itemId,
    required this.isChecked,
    required this.toggleIsSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        toggleIsSelected(itemId, !isChecked); // Toggle the selection state
      },
      child: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          color: isChecked ? AppColor.modulorRed : AppColor.backgroundGrey,
          borderRadius: BorderRadius.circular(8),
        ),
        child: isChecked
            ? const Icon(Icons.check, color: Colors.white, size: 24)
            : null,
      ),
    );
  }
}