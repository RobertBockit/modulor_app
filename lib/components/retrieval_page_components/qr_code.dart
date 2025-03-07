import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../constants/colors.dart';

class QrCode extends StatelessWidget{
  final String id;


  const QrCode({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(11),
        ),
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                Text(
                  "Qr Code Scanning",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                Text("Humboldt University Locker #2"),
                Text("Scan this QR-Code to start retrieving items from the locker. ",
                    ),]),
                const SizedBox(height: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  QrImageView(data: id, size: 262),
                  const SizedBox(height: 11,),
                  Text("Help, it doesn't work", style: TextStyle(
                    decoration: TextDecoration.underline,
                    decorationColor: AppColor.modulorRed,
                    color: AppColor.modulorRed,
                  ),)


                  ],),
                const SizedBox(height: 11,),
              ],
            )));
  }
}