import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class ToggleCheckBox extends StatefulWidget {
  @override
  _ToggleCheckBoxState createState() => _ToggleCheckBoxState();
}

class _ToggleCheckBoxState extends State<ToggleCheckBox> {
  bool isChecked = true; // Initial state

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isChecked = !isChecked; // Toggle state
        });
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
            : null, // No icon when unchecked
      ),
    );
  }
}
