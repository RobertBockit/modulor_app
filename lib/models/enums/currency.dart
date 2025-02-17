enum Currency {
  EUR,
  USD,
}

extension CurrencyName on Currency {
  String get value {
    switch (this) {
      case Currency.EUR:
        return '€';
      case Currency.USD:
        return '\$';
      default:
        return "€";
    }
  }
}
