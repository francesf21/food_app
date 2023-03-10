import 'package:flutter/material.dart';

import 'package:food_app/res/res.dart';

class ErrorComponent extends StatelessWidget {
  final IconData icon;
  final String titleError;
  final String bodyError;
  final String textButtonTry;
  final bool isbutton;
  final void Function()? onPressed;

  const ErrorComponent({
    Key? key,
    required this.icon,
    required this.titleError,
    required this.bodyError,
    this.textButtonTry = '',
    this.onPressed,
    this.isbutton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              right: Dimens.d40,
            ),
            child: Icon(
              icon,
              size: 150,
              color: AppColors.backgroundItem,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: Dimens.d16,
              left: Dimens.d40,
              right: Dimens.d40,
            ),
            child: Column(
              children: [
                Text(
                  titleError,
                  textAlign: TextAlign.center,
                  style: AppStyle.instance.bodyText,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: Dimens.d12,
                    left: Dimens.d80,
                    right: Dimens.d80,
                  ),
                  child: Text(
                    bodyError,
                    style: AppStyle.instance.errorbody,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          isbutton
              ? Padding(
                  padding: const EdgeInsets.only(
                    top: Dimens.d40,
                  ),
                  child: ElevatedButton(
                    onPressed: onPressed,
                    child: Text(
                      textButtonTry,
                      style: AppStyle.instance.bodyMedium.copyWith(
                        fontSize: Dimens.d18,
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
