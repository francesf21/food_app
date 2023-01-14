import 'package:flutter/material.dart';
import 'package:food_app/res/res.dart';

class ItemButtonProfile extends StatelessWidget {
  final String text;
  final IconData icon;
  final void Function()? onTap;

  const ItemButtonProfile({
    Key? key,
    required this.text,
    required this.icon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.d24,
        vertical: Dimens.d6,
      ),
      child: SizedBox(
        width: double.infinity,
        height: 70,
        child: Card(
          elevation: Dimens.d8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimens.d16),
          ),
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(Dimens.d16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    text,
                    textAlign: TextAlign.start,
                    style: AppStyle.instance.bodyMediumBlack,
                  ),
                  Icon(
                    icon,
                    color: AppColors.blackColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
