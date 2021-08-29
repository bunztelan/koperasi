import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Shimmer.fromColors(
            baseColor: Color(0xFFDFE6E9),
            highlightColor: Colors.white,
            child: Container(
              width: 50,
              height: 50,
              color: Colors.grey,
            ),
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Shimmer.fromColors(
          baseColor: Color(0xFFECF0F1),
          highlightColor: Colors.white,
          child: Container(
            child: Container(
              width: 50,
              height: 8,
              color: Colors.grey,
            ),
          ),
        )
      ],
    );
  }
}
