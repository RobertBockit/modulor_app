import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class HomeScreenPoster extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.backgroundGrey,
      height: 390,
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded( // Ensures the image scales proportionally within its parent
            child: Image.network(
              'https://cdn.modulor.de/module/1639d9d9588889718894ca6701481247_700_525.jpg',
              fit: BoxFit.cover, // Ensures the image covers the available space without overflow
            ),
          ),
        ],
      ),
    );
  }
}
