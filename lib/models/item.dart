import 'price.dart';

class Item {
  String productId = "";
  num amount = 1;
  String productIcon = "";
  String productName = "";
  bool isSelected = true;
  late Price productPrice;
  Item(this.productId, this.productIcon, this.productName, this.productPrice,
      this.isSelected);
}
