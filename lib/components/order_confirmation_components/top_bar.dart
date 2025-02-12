import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TopBar extends StatelessWidget {
  final String value;

  const TopBar({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(value),
      leading: Icon(Icons.arrow_back),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(11),
        ),
      ),
    );
  }
}
