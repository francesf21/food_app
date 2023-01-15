import 'package:flutter/material.dart';
import 'package:food_app/res/color.dart';

/// conjunto de metodos donde se motrara el snackbar
extension ShowSnackBar on BuildContext {
  /// Muestra un snackbar básico
  void showSnackBar({
    required String message,
    Color backgroundColor = Colors.white,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
    ));
  }

  /// Muestra una barra roja que indica un error
  void showErrorSnackBar({required String message}) {
    showSnackBar(
      message: message,
      backgroundColor: AppColors.primaryColor,
    );
  }
}
