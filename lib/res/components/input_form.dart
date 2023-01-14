import 'package:flutter/material.dart';
import 'package:food_app/res/res.dart';

class InputForm extends StatelessWidget {
  final String textLabel;
  final TextInputType textInputType;
  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String?)? onValidate;

  const InputForm({
    Key? key,
    required this.textLabel,
    required this.controller,
    this.textInputType = TextInputType.text,
    this.obscureText = false,
    this.onValidate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: Dimens.d6,
        left: Dimens.d24,
        right: Dimens.d24,
        bottom: Dimens.d6,
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: onValidate,
        cursorColor: AppColors.primaryColor,
        keyboardType: textInputType,
        decoration: InputDecoration(
          border: const UnderlineInputBorder(),
          labelStyle: const TextStyle(
            color: AppColors.blackColor,
          ),
          labelText: textLabel,
        ),
      ),
    );
  }
}
