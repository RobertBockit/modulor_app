import 'package:flutter/material.dart';
import 'package:modulor_app/models/enums/currency.dart';
import '../../constants/colors.dart';
import '../../models/price.dart';
import '../../models/product.dart';
class ProductCard extends StatelessWidget {
  const ProductCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String imageUrl = "https://via.placeholder.com/150";
    final String title =
        "This product.";
    final String tag = "Product Tag";
    final double rating = 4.02;
    final int reviewsCount = 192;
    final String salesInfo = "400+ bought last year";
    final String price = "9.90€";
    final String perUnitPrice = "(0.99€ / pcs.)";
    final int starAmount = rating ~/ 1;
    String stars = "★" * starAmount + "☆" * (5 - starAmount);
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 173, // Minimum height is always 173
      ),
      child: IntrinsicHeight(
        child: Container(
          margin: EdgeInsets.only(left: 5.0, top: 2.5, right: 5.0, bottom: 2.5),
          color: AppColor.backgroundGrey,
          width: double.infinity,
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  child: Image.network(
                    "https://www.modulor.de/magazin/wp-content/uploads/2022/08/3_1920_1920_r_avolt_square_1_mehrfachsteckdose_usb_magnet_2_x_usb_2_1a_5v_3_x_230_v_kabel_1_8_m_moorgrun-e1661852485289.png",
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  padding: EdgeInsets.only(left: 5.0, right:5.0, top: 15.0, bottom: 15.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColor.backgroundGrey),
                    color: Colors.white
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColor.paragraphBlack,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          height: 1.2
                        ),
                      ),
                      SizedBox(height: 3),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 3, vertical: 1), // Adjust padding for pill shape
                    decoration: BoxDecoration(
                      color: AppColor.backgroundGrey, // Background color of the pill
                      border: Border.all(color: Colors.white), // Border color same as the background
                    ),
                    child: Text(
                      tag,
                      style: TextStyle(
                        color: AppColor.paragraphBlack,
                        fontSize: 14,
                      ),
                    ),),
                      SizedBox(height: 4),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [Row(
                          children: [
                            Text("$rating"),
                            Text(" $stars ",
                              style: TextStyle(
                                  color: AppColor.ratingOrange
                              ),
                            ),
                            Text("($reviewsCount reviews)"),
                          ],
                        ),
                          Transform.translate(
                              offset: Offset(0, -5),
                              child: Text(salesInfo,
                              style: TextStyle(color: AppColor.paragraphGrey),))
                          ],
                      ),
                      Row(
                        spacing: 5.0,
                        children: [Text(price, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Text(perUnitPrice, style: TextStyle(fontSize: 14, color: AppColor.paragraphGrey)),],
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 34.0,
                        child:  ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color>(AppColor.modulorRed),
                              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero,
                                  )
                              )
                          ),
                          onPressed: () {},
                          child: Text("Buy Now",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
