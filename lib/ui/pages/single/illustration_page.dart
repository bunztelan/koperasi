import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:k2ms_v2/config/color_config.dart';
import 'package:supercharged/supercharged.dart';

class IllustrationPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final String picturepath;
  final String buttonTitle1;
  final String buttonTitle2;
  final Function buttonAction1;
  final Function buttonAction2;
  final double width;
  final double height;

  IllustrationPage({
    @required this.title,
    @required this.subtitle,
    @required this.picturepath,
    @required this.buttonTitle1,
    this.buttonTitle2,
    @required this.buttonAction1,
    this.buttonAction2,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: width??150,
            height: height??150,
            margin: EdgeInsets.only(bottom: 50),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(picturepath),
              ),
            ),
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyText1.copyWith(
              fontWeight: FontWeight.w300,
              fontSize: 18,
              color: '020202'.toColor(),
            ),
          ),
          SizedBox(height: 8),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyText1.copyWith(
              color:'8D92A3'.toColor(),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40),
          Container(
            width: double.infinity,
            child: TextButton(
              onPressed: buttonAction1,
              child: Text(
                buttonTitle1,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Colors.white,fontWeight: FontWeight.w600),
              ),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(AppColor.primaryColor),
                padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(vertical: 16, horizontal: 50),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
