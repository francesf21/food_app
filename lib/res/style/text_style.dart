import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:food_app/res/color.dart';

class AppStyle {
  static AppStyle instance = AppStyle._init();

  AppStyle._init();

  final TextStyle h1Bold = GoogleFonts.eczar(
    color: AppColors.whiteColor,
    fontSize: 48,
    fontWeight: FontWeight.w700,
  );

  final TextStyle h2Bold = GoogleFonts.eczar(
    color: AppColors.whiteColor,
    fontSize: 40,
    fontWeight: FontWeight.w700,
  );

  final TextStyle h2BoldBlack = GoogleFonts.eczar(
    color: AppColors.blackColor,
    fontSize: 40,
    fontWeight: FontWeight.w700,
  );

  final TextStyle h4Bold = GoogleFonts.eczar(
    color: AppColors.whiteColor,
    fontSize: 28,
    fontWeight: FontWeight.w700,
  );

  final TextStyle h5Bold = GoogleFonts.eczar(
    color: AppColors.whiteColor,
    fontSize: 26,
    fontWeight: FontWeight.w700,
  );

  final TextStyle h5BoldBlack = GoogleFonts.eczar(
    color: AppColors.blackColor,
    fontSize: 26,
    fontWeight: FontWeight.w700,
  );

  final TextStyle bodyXLarge = GoogleFonts.eczar(
    color: AppColors.whiteColor,
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );

  final TextStyle bodyXLargeBlack = GoogleFonts.eczar(
    color: AppColors.blackColor,
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );

  final TextStyle bodyMedium = GoogleFonts.eczar(
    color: AppColors.whiteColor,
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  final TextStyle bodyMediumBlack = GoogleFonts.eczar(
    color: AppColors.blackColor,
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );
  final TextStyle bodyMediumItems = GoogleFonts.eczar(
    color: AppColors.primaryColor,
    fontSize: 14,
    fontWeight: FontWeight.w300,
  );

  final TextStyle titleText = GoogleFonts.pacifico(
    color: AppColors.blackColor,
    fontSize: 30,
    fontWeight: FontWeight.w500,
  );

  final TextStyle bodyText = GoogleFonts.eczar(
    color: AppColors.blackColor,
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  final TextStyle errorbody = GoogleFonts.poppins(
    color: AppColors.blackColor,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );
}
