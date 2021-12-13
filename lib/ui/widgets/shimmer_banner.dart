import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:k2ms_v2/config/color_config.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(height: 200.0),
      items: [1, 2, 3].map((e) {
        return Builder(
          builder: (BuildContext context) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Shimmer.fromColors(
                baseColor: Color(0xFFDFE6E9),
                highlightColor: Colors.white,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 160,
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    color: AppColor.softGrayColor,
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
