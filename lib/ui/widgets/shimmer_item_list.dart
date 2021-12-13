import 'package:flutter/material.dart';
import 'package:k2ms_v2/config/color_config.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerItemList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [1, 2, 3]
          .map((_) => Shimmer.fromColors(
                baseColor: Color(0xFFDFE6E9),
                highlightColor: Colors.white,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(
                    bottom: 24,
                    right: 24,
                    left: 24,
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: AppColor.softGrayColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 3,
                              ),
                              Container(
                                width: 80,
                                height: 10,
                                color: AppColor.softGrayColor,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: 70,
                                height: 10,
                                color: AppColor.softGrayColor,
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ))
          .toList(),
    );
  }
}
