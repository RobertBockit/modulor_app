import 'package:modulor_app/models/enums/order_status.dart';
import 'package:intl/intl.dart';

class OrderItem{
   late String orderId;
   late OrderStatus orderStatus;
   late int amountOfItem;
   late String date;

   OrderItem({required this.orderId, required this.orderStatus, required this.amountOfItem, required this.date});

   factory OrderItem.fromJson(Map<String, dynamic> json) {
      return OrderItem(
        orderId: json["documentId"],
         orderStatus: OrderStatus.values.byName(json["orderStatus"]),
         amountOfItem: json["items"].length,
         date: DateFormat('dd.MM').format(DateTime.parse(json["createdAt"])),
      );
   }

}