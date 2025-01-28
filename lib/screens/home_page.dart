import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:modulor_app/components/featured_categories/featured_categories.dart';
import 'package:modulor_app/components/home_screen_poster/home_screen_poster.dart';
import 'package:modulor_app/components/product_card/product_card.dart';
import 'package:modulor_app/screens/product_details.dart';
import 'package:provider/provider.dart';

import '../components/top_menu/top_menu.dart';
import '../models/product.dart';
import '../providers/app_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, state, child) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 200,
          backgroundColor: Colors.white,
          title: const Padding(
            padding: EdgeInsets.only(left: 2, right: 2),
            child: Column(
              children: [Text("items")],
            ),
          ),
          scrolledUnderElevation: 0,
        ),
        body: RefreshIndicator(
          onRefresh: () async => state.pagingController.refresh(),
          child: PagedListView<int, Product>(
            cacheExtent: 9999,
            pagingController: state.pagingController,
            builderDelegate: PagedChildBuilderDelegate<Product>(
              animateTransitions: true,
              itemBuilder: (context, product, index) => GestureDetector(
                onTap: () {

                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                  child: ProductCard(
                    title: product.title,
                    imageUrl: product.img,
                    price: product.price,
                    onAddToCart: () {},
                    description: 'adawdadawd',
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}