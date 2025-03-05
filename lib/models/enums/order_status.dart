import 'dart:ui';

import 'package:modulor_app/constants/colors.dart';

enum OrderStatus {
  UNPAID,
  PAYMENT_PENDING,
  PAID,
  PICKUP,
  PARTIALLY_COMPLETED,
  COMPLETED,
  CANCELED,
}

class OrderStatusValue{
  String value;
  Color color;
  OrderStatusValue({required this.value, required this.color});
}

extension OrderStatusText on OrderStatus {
  OrderStatusValue get value {
    switch (this) {
      case OrderStatus.UNPAID:
        return OrderStatusValue(value: "Unpaid", color: AppColor.modulorRedDisabled);
      case OrderStatus.PAYMENT_PENDING:
        return OrderStatusValue(value: "Payment in progress", color: AppColor.ratingOrange);
      case OrderStatus.PAID:
        return OrderStatusValue(value: "Awaiting delivery", color: AppColor.paragraphGrey);
      case OrderStatus.PICKUP:
        return OrderStatusValue(value: "Awaiting pickup", color: AppColor.successGreen);
      case OrderStatus.PARTIALLY_COMPLETED:
        return OrderStatusValue(value: "Partially completed", color: AppColor.ratingOrange);
      case OrderStatus.COMPLETED:
        return OrderStatusValue(value: "Collected", color: AppColor.paragraphBlack);
      case OrderStatus.CANCELED:
        return OrderStatusValue(value: "Canceled", color: AppColor.modulorRed);
    }
  }
}

