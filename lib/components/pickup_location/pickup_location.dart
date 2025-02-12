import 'package:flutter/material.dart';
import 'package:modulor_app/constants/colors.dart';

class PickUpLocation extends StatelessWidget {
  const PickUpLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        // color: Colors.white,
        width: double.infinity, // Растягиваем по ширине
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(11), // Закругление углов
        ),
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Pick up location",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                Text("Humboldt University Locker #2"),
                Text("Anna-Roberts-Terehovics Straße 52, 13349 Berlin.",
                    style: TextStyle(fontStyle: FontStyle.italic)),
                Text("How to find?",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationColor: AppColor.modulorRed,
                      color: AppColor.modulorRed,
                    ))
              ],
            )));
  }
}
