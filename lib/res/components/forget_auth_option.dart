import 'package:flutter/material.dart';
import 'package:food_app/res/res.dart';

class ForgetAuthOption extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  final String action;
  final bool isRight;

  const ForgetAuthOption({
    Key? key,
    this.onPressed,
    required this.text,
    required this.action,
    this.isRight = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double dimenLeft = isRight ? Dimens.d8 : Dimens.d40;
    final double paddingRight = isRight ? Dimens.d24 : 0.0;

    return Padding(
      padding: EdgeInsets.only(
        top: dimenLeft,
        right: paddingRight,
      ),
      child: Row(
        crossAxisAlignment:
            isRight ? CrossAxisAlignment.end : CrossAxisAlignment.center,
        mainAxisAlignment:
            isRight ? MainAxisAlignment.end : MainAxisAlignment.center,
        children: [
          Text(text),
          TextButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(
              backgroundColor: Colors.transparent,
              foregroundColor: AppColors.primaryColor,
            ),
            child: Text(action),
          ),
        ],
      ),
    );
  }
}
