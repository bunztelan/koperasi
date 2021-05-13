import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color_config.dart';

ThemeData get defaultStyleConfig => ThemeData(
  scaffoldBackgroundColor: Colors.white,
  backgroundColor: Colors.white,
  primaryColor: AppColor.primaryColor,
  textTheme: TextTheme(
    headline3: GoogleFonts.poppins(
      color: AppColor.textPrimaryColor,
    ),
    headline4: GoogleFonts.poppins(
      color: AppColor.textPrimaryColor,
      fontWeight: FontWeight.w700,
    ),
    headline5: GoogleFonts.poppins(
      color: AppColor.textPrimaryColor,
      fontWeight: FontWeight.w700,
    ),
    headline6: GoogleFonts.poppins(
      fontWeight: FontWeight.w700,
      color: AppColor.textPrimaryColor,
    ),
    subtitle1: GoogleFonts.poppins(
      color: AppColor.textPrimaryColor,
      fontWeight: FontWeight.w700,
    ),
    subtitle2: GoogleFonts.poppins(
      color: AppColor.textPrimaryColor,
    ),
    bodyText1: GoogleFonts.poppins(
      color: AppColor.textPrimaryColor,
      fontSize: 16
    ),
    bodyText2: GoogleFonts.poppins(
      color: AppColor.textPrimaryColor,
      height: 1.5,
    ),
  ),
  appBarTheme: AppBarTheme(
      elevation: 0.5,
      color: Colors.white,
      textTheme: TextTheme(
        headline6: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: AppColor.textPrimaryColor,
        ),
      ),
      iconTheme: IconThemeData(
        color: AppColor.textPrimaryColor,
      ),
      centerTitle: true),
  buttonTheme: ButtonThemeData(
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    padding: EdgeInsets.symmetric(vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: GoogleFonts.poppins(
      fontWeight: FontWeight.w500,
    ),
  ),
);


const double kDefaultMargin = 24;
const double kVerticalSpacing = 8;
const double kHorizontalSpacing = 4;
const double kDefaultRadius = 12;
