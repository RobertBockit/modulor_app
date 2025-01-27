import 'package:flutter/material.dart';

class HomeScreenPoster extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Image.network('https://cdn.modulor.de/module/1639d9d9588889718894ca6701481247_700_525.jpg'),
      );
  }
}