import 'package:flutter/material.dart';

import '../../constants/colors.dart';

void showHowToFindBottomSheet(BuildContext context) {
  showModalBottomSheet(
    backgroundColor: Colors.white,
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(11.0)),
    ),
    builder: (BuildContext context) {
      return FractionallySizedBox(
        heightFactor: 0.7,
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Humboldt University Locker #2",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700)),
                        Icon(Icons.clear)
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          "assets/humbolt.png",
                          width: 399,
                          height: 256,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                            "Only University Students can access this packstation!",
                            style: TextStyle(
                              color: AppColor.modulorRed,
                              fontWeight: FontWeight.w600,
                            )),
                        const SizedBox(
                          height: 15,
                        ),
                        Text.rich(
                          TextSpan(text: "To find the ", children: [
                            TextSpan(
                                text: "“Humboldt University Locker #2” ",
                                style: TextStyle(fontWeight: FontWeight.w600)),
                            TextSpan(
                                text:
                                    "go to the main hall of the university building.")
                          ]),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Walk around the cafe, and look for a modulor packstation below the library. ",
                        )
                      ],
                    ),
                  ],
                ),
                Align(
                    alignment: Alignment.bottomLeft,
                    widthFactor: 1,
                    heightFactor: 0.5,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.modulorRed,
                            minimumSize: Size(double.infinity, 63),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(11)))),
                        child: Text(
                          "Okay!",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        )))
              ],
            )),
      );
    },
  );
}
