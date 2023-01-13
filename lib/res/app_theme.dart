import 'package:flutter/material.dart';
import 'package:food_app/res/res.dart';

class AppTheme {
  ThemeData appTheme() {
    return ThemeData(
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.backgroundColor,
      appBarTheme: AppBarTheme(
        surfaceTintColor: AppColors.whiteColor,
        scrolledUnderElevation: 2,
        toolbarTextStyle: AppStyle.instance.bodyMedium,
        iconTheme: const IconThemeData(color: AppColors.primaryColor),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: AppColors.whiteColor,
          padding: const EdgeInsets.symmetric(
            vertical: Dimens.d16,
            horizontal: Dimens.d80,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        fillColor: MaterialStateProperty.all(AppColors.primaryColor),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.whiteColor.withOpacity(0.1),
        focusedBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(color: AppColors.primaryColor),
        ),
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        hoverColor: AppColors.primaryColor,
        contentPadding: const EdgeInsets.all(20),
        prefixIconColor: AppColors.whiteColor.withOpacity(0.4),
        suffixIconColor: AppColors.whiteColor.withOpacity(0.4),
        hintStyle: AppStyle.instance.bodyMedium.copyWith(
          color: AppColors.whiteColor.withOpacity(0.4),
        ),
      ),
    );
  }
}
