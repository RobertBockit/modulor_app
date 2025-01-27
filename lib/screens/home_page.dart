import 'package:flutter/material.dart';
import 'package:modulor_app/components/home_screen_poster/home_screen_poster.dart';
import 'package:modulor_app/components/product_card/product_card.dart';

import '../components/top_menu/top_menu.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [TopMenu(), HomeScreenPoster(),
        ProductCard(),],
      crossAxisAlignment: CrossAxisAlignment.start,),
    );
  }
}
