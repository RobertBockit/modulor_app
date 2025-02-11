import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../constants/colors.dart';

final List<String> imgList = [
  'https://i5.walmartimages.com/asr/2f94c814-4fa2-4a5b-a2e4-8c85ee9eab38.abc41b271fbc6e523e1c15e6af231043.jpeg?odnHeight=768&odnWidth=768&odnBg=FFFFFF',
  'https://bellard.org/bpg/2.png',
  'https://bellard.org/bpg/2.png',
  'https://bellard.org/bpg/2.png',
  'https://bellard.org/bpg/2.png',
  'https://bellard.org/bpg/2.png',
];

class CarouselWithIndicatorDemo extends StatefulWidget {
  @override
  State<CarouselWithIndicatorDemo> createState() =>
      _CarouselWithIndicatorState();
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicatorDemo> {
  int _current = 0; // Track current index

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: height * 0.4,
            viewportFraction: 1.0,
            enlargeCenterPage: false,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index; // Update index on slide change
              });
            },
          ),
          items: imgList.map((item) {
            return Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    color: Colors.white,
                  ),
                ),
                // Image with Padding
                Padding(
                  padding:
                      const EdgeInsets.all(11.0), // 10px padding from all sides
                  child: Center(
                    child: Image.network(
                      item,
                      fit: BoxFit.contain,
                      height: height * 0.4,
                      width: double.infinity,
                    ),
                  ),
                ),
                // Black Overlay with 4% Opacity
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withOpacity(0.04),
                  ),
                ),
              ],
            );
          }).toList(),
        ),

        // Indicator Dots
        Container(
          padding: EdgeInsets.only(top: 20, bottom: 20),
          color: AppColor.backgroundGrey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imgList.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => setState(() => _current = entry.key),
                child: Container(
                  width: 10.0,
                  height: 10.0,
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == entry.key
                        ? Color.fromRGBO(131, 148, 132, 1)
                        : Color.fromRGBO(217, 217, 217, 1),
                  ),
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}
