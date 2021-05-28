import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';

import '../../config/color_config.dart';

class CustomHeader extends StatelessWidget {
  final String title;
  final String subTitle;
  final bool backButton;
  BuildContext parentContext;
  Function backFunction;

  CustomHeader({
    this.title,
    this.subTitle,
    this.backButton = false,
    this.parentContext,
    this.backFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 24),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              backFunction == null
                  ? Beamer.of(context).beamBack()
                  : backFunction();
            },
            child: Icon(
              Icons.chevron_left_sharp,
              size: 50,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              Text(
                subTitle,
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                      fontSize: 14,
                      color: AppColor.black30,
                    ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
