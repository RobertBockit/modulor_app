import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../components/top_menu/top_menu.dart';
import '../components/categories_list/categories_row.dart';
import '../components/product_card/product_card.dart';
import '../models/item.dart';
import '../models/product.dart';
import '../providers/app_provider.dart';
import '../providers/cart_provider.dart';

class HomePage extends StatelessWidget {
  final ScrollController scrollController;
  final bool isInitiallyScrolled;

  const HomePage({
    Key? key,
    required this.scrollController,
    this.isInitiallyScrolled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, state, child) => Scaffold(
        body: Column(
          children: [

            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 12, left: 12, top: 5),
                child: RefreshIndicator(
                  onRefresh: () async => state.pagingController.refresh(),
                  child: NestedScrollView(
                    controller: scrollController,
                    headerSliverBuilder: (context, innerBoxIsScrolled) {
                      return [
                        SliverToBoxAdapter(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: const Text(
                                  "All Categories",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              CategoriesRow(),
                              const SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: const Text(
                                  "All Items",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ];
                    },
                    body: PagedMasonryGridView<int, Product>(
                      padding: EdgeInsets.only(top: 10),
                      cacheExtent: 50,
                      pagingController: state.pagingController,
                      gridDelegateBuilder: (context) =>
                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      builderDelegate: PagedChildBuilderDelegate<Product>(
                        animateTransitions: true,
                        itemBuilder: (context, product, index) => ProductCard(
                          productId: product.id,
                          title: product.title,
                          imageUrl: product.img,
                          price: product.price,
                          onAddToCart: () {
                            Provider.of<CartProvider>(context, listen: false).addItem(
                              Item(
                                product.id,
                                product.img,
                                product.title,
                                product.price,
                                true,
                              ),
                            );
                          },
                          description: 'Product Description',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
