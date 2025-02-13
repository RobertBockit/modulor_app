import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../components/product_card/product_card.dart';
import '../models/item.dart';
import '../models/price.dart';
import '../models/product.dart';
import '../providers/app_state.dart';
import '../providers/cart_provider.dart';

class HomePage extends StatelessWidget {
  final ScrollController scrollController;

  const HomePage({Key? key, required this.scrollController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, state, child) => Scaffold(
        body: Padding(
          padding: EdgeInsets.only(left: 12, right: 12),
          child: RefreshIndicator(
            onRefresh: () async => state.pagingController.refresh(),
            child: PagedMasonryGridView<int, Product>(
              cacheExtent: 50,
              pagingController: state.pagingController,
              gridDelegateBuilder: (context) =>
                  SliverSimpleGridDelegateWithFixedCrossAxisCount(
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
                  description: 'adawdadawd',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
