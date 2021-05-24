import 'package:flutter/material.dart';
import 'package:k2ms_v2/config/color_config.dart';

class CustomHeader extends StatelessWidget {
  final String title;
  final String subTitle;

  CustomHeader({this.title, this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          Text(
            subTitle,
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                  fontSize: 13,
                  color: AppColor.black30,
                ),
          )
        ],
      ),
    );
  }
}
