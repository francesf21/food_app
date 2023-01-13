import 'package:flutter/material.dart';

import 'package:food_app/res/res.dart';
import 'package:food_app/routes/routes.dart';
import 'package:food_app/res/components/components.dart';

class OnboardScreen extends StatelessWidget {
  const OnboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      top: false,
      child: Container(
        width: size.width,
        height: size.height,
        color: AppColors.primaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: Dimens.d60,
                bottom: Dimens.d24,
                left: Dimens.d24,
              ),
              child: CircleAvatar(
                radius: Dimens.d40,
                backgroundColor: AppColors.whiteColor,
                child: Image.asset(
                  AppString.instance.pathOnboardImageIcon,
                  height: Dimens.d60,
                ),
              ),
            ),
            AppText(
              text: AppString.instance.textTileOnboard,
              leftPadding: Dimens.d24,
              bottomPadding: Dimens.d24,
              style: AppStyle.instance.h1Bold,
            ),
            _ExpandedImage(size: size),
          ],
        ),
      ),
    );
  }
}

class _ExpandedImage extends StatelessWidget {
  final Size size;

  const _ExpandedImage({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Image.asset(
            AppString.instance.pathOnboardImage,
            width: size.width,
            height: size.height,
            fit: BoxFit.cover,
          ),
          Positioned(
            left: Dimens.d24,
            right: Dimens.d24,
            bottom: 10,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: Dimens.d32,
              ),
              child: ElevatedButton(
                onPressed: () {
                  Future.delayed(Duration.zero, () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      RoutesName.login,
                      ((route) => false),
                    );
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.whiteColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
                child: Text(
                  AppString.instance.textButtonOnboard,
                  style: AppStyle.instance.bodyMedium.copyWith(
                    color: AppColors.primaryColor,
                    fontSize: Dimens.d18,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
