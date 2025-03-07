import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class CarouselWithIndicatorDemo extends StatefulWidget {
  final String imageUrl;

  CarouselWithIndicatorDemo({required this.imageUrl});

  @override
  State<CarouselWithIndicatorDemo> createState() =>
      _CarouselWithIndicatorState();
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicatorDemo> {
  late List<String> imgList;
  int _current = 0;

  @override
  void initState() {
    super.initState();
    imgList = [widget.imageUrl];
    print(imgList);
  }

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
                _current = index;
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
                Padding(
                  padding:
                  const EdgeInsets.all(11.0),
                  child: Center(
                    child: Image.network(
                      item,
                      fit: BoxFit.contain,
                      height: height * 0.4,
                      width: double.infinity,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withOpacity(0.04),
                  ),
                ),
              ],
            );
          }).toList(),
        ),

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
