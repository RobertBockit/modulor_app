import 'enums/currency.dart';

class Price {
  Price(this.currency, this.price);
  Currency currency = Currency.EUR;
  double price = 0;

  String toStringAsFixed(int fractionDigits) {
    return price.toStringAsFixed(fractionDigits);
  }

  double toDouble() {
    return price;
  }
}
