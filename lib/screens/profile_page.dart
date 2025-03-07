import 'package:flutter/material.dart';
import 'package:modulor_app/components/profile_components/orders_list.dart';
import 'package:modulor_app/constants/colors.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundGrey,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:[OrdersList(isActive: true,),SizedBox(height: 20), OrdersList(isActive: false) ]),
        ),
      ),
    );
  }
}
