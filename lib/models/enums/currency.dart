enum Currency {
  euro,
  usd,
}

extension CurrencyName on Currency{
  String get value {
    switch (this) {
      case Currency.euro:
        return '€';
      case Currency.usd:
        return '\$';
      default:
        return "€";
    }
  }
}
