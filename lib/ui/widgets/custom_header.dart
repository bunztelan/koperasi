import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';

import '../../config/color_config.dart';

class CustomHeader extends StatelessWidget {
  final String title;
  final String subTitle;
  final bool backButton;
  final BuildContext parentContext;
  final Function backFunction;

  CustomHeader({
    this.title,
    this.subTitle,
    this.backButton = true,
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
          backButton
              ? GestureDetector(
                  onTap: () {
                    backFunction == null
                        ? Beamer.of(context).beamBack()
                        : backFunction();
                  },
                  child: Icon(
                    Icons.chevron_left_sharp,
                    size: 50,
                  ),
                )
              : SizedBox(width: 24),
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
