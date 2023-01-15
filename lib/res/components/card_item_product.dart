import 'package:flutter/material.dart';
import 'package:food_app/res/res.dart';

class CardItemProduct extends StatelessWidget {
  final String nameProduct;
  final double priceoProduct;
  final String urlProduct;

  const CardItemProduct({
    Key? key,
    required this.nameProduct,
    required this.priceoProduct,
    required this.urlProduct,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 400,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: Dimens.d70,
              left: Dimens.d8,
              right: Dimens.d8,
            ),
            child: Card(
              elevation: Dimens.d12,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Dimens.d24),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 220,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: Dimens.d8,
                        right: Dimens.d8,
                        top: Dimens.d8,
                      ),
                      child: Center(
                        child: Text(
                          nameProduct,
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
                        'S/. $priceoProduct',
                        style: AppStyle.instance.bodyMediumBlack,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: Dimens.d8),
                      child: TextButton.icon(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: AppColors.primaryColor,
                        ),
                        onPressed: () {},
                        label: Text(
                          AppString.instance.addText,
                        ),
                        icon: const Icon(Icons.shopping_cart_outlined),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 138,
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
                  backgroundImage: NetworkImage(urlProduct),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
