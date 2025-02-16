import 'package:uuid/v4.dart';
import 'enums/currency.dart';
import 'price.dart';
import 'item.dart';

class Order {
  String id = "";
  List<Item> orderItems = [];
  Price totalPrice = Price(Currency.EUR, 0);
  num totalAmount = 0;

  Order(this.orderItems) {
    id = const UuidV4().generate();
    calculateTotalPrice();
    calculateTotalAmount();
  }

  void calculateTotalPrice() {
    double newPrice = 0;
    for (var el in orderItems) {
      newPrice += el.productPrice.price * el.amount;
    }
    totalPrice = Price(Currency.EUR, newPrice);
  }

  void calculateTotalAmount() {
    num newTotalAmount = 0;
    for (var el in orderItems) {
      newTotalAmount += el.amount;
    }

    totalAmount = newTotalAmount;
  }

  void addNewProduct(Item newItem) {
    var indexOfNewItem =
        orderItems.indexWhere((i) => i.productId == newItem.productId);

    if (indexOfNewItem != -1) {
      orderItems[indexOfNewItem].amount += 1;
    } else {
      orderItems.add(newItem);
    }
    calculateTotalPrice();
    calculateTotalAmount();
  }

  void removeProduct(String id) {
    orderItems.remove(orderItems.firstWhere((el) => el.productId == id));
    calculateTotalPrice();
    calculateTotalAmount();
  }

  void clearOrder() {
    orderItems.clear();
    calculateTotalPrice();
    calculateTotalAmount();
  }
}
