import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class ToggleCheckBox extends StatefulWidget {
  final bool isChecked;
  final void Function(String id, bool isSelected) toggleIsSelected;
  final String itemId;

  const ToggleCheckBox({
    Key? key,
    required this.isChecked, required this.toggleIsSelected, required this.itemId,
  }) : super(key: key);

  @override
  _ToggleCheckBoxState createState() => _ToggleCheckBoxState();
}

class _ToggleCheckBoxState extends State<ToggleCheckBox> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.isChecked;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
        });
        widget.toggleIsSelected(widget.itemId, isChecked);
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
