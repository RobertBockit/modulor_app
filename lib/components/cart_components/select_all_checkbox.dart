import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class SelectAllCheckbox extends StatefulWidget {
  final bool isChecked;
  final Function(bool) onTap; // Callback function to handle tap events

  const SelectAllCheckbox({
    Key? key,
    required this.isChecked,
    required this.onTap, // Add the callback as a required parameter
  }) : super(key: key);

  @override
  _SelectAllCheckboxState createState() => _SelectAllCheckboxState();
}

class _SelectAllCheckboxState extends State<SelectAllCheckbox> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.isChecked;
  }

  @override
  void didUpdateWidget(SelectAllCheckbox oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update the state if the parent widget changes the isChecked value
    if (oldWidget.isChecked != widget.isChecked) {
      setState(() {
        isChecked = widget.isChecked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isChecked = !isChecked; // Toggle the checkbox state
        });
        widget.onTap(isChecked); // Execute the callback function
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