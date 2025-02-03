import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/navbar/navbar.dart';
import '../providers/app_state.dart';

class ProductDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: Center(
        child: Column(
          children: [
            Image.network('your_product_image_url_here'),
            Text('Product Name'),
            Text('Product Description'),
            ElevatedButton(
              onPressed: () {
                appState.updateSelectedIndex(2);
              },
              child: Text('Back to Home'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
