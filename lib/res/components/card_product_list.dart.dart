import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/res/res.dart';

class CardProductList extends StatelessWidget {
  final String image;
  final String name;
  final double price;
  final bool statusFavorite;

  final void Function()? onPressed;

  const CardProductList({
    Key? key,
    required this.image,
    required this.name,
    required this.price,
    required this.statusFavorite,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 16),
                height: 100,
                width: 150,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Center(
                  child: Material(
                    shape: const CircleBorder(
                      side: BorderSide.none,
                    ),
                    elevation: Dimens.d16,
                    child: CircleAvatar(
                      radius: 100,
                      backgroundImage: NetworkImage(image),
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: Dimens.d6),
                    child: Center(
                      child: Text(
                        name,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: AppStyle.instance.bodyText,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: Dimens.d8,
                      right: Dimens.d8,
                    ),
                    child: Text(
                      'S/. $price',
                      style: AppStyle.instance.errorbody,
                    ),
                  ),
                ],
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: Dimens.d8,
              right: Dimens.d16,
            ),
            child: TextButton.icon(
              style: TextButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: AppColors.primaryColor,
              ),
              onPressed: onPressed,
              label: Text(
                AppString.instance.addText,
              ),
              icon: FaIcon(
                statusFavorite
                    ? FontAwesomeIcons.heartCircleCheck
                    : FontAwesomeIcons.heart,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
