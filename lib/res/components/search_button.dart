import 'package:flutter/material.dart';
import 'package:food_app/res/res.dart';
import 'package:food_app/routes/routes.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.d24,
        vertical: Dimens.d16,
      ),
      child: InkWell(
        onTap: () {
          Future.delayed(Duration.zero, () {
            Navigator.of(context).pushNamed(
              RoutesName.search,
            );
          });
        },
        child: Container(
          height: Dimens.d60,
          width: double.infinity,
          decoration: const ShapeDecoration(
            shape: StadiumBorder(),
            color: AppColors.greyColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(Dimens.d16),
            child: Row(
              children: [
                const Icon(Icons.search),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.d8,
                  ),
                  child: Text(AppString.instance.textSearch),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
