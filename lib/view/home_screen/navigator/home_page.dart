import 'package:flutter/material.dart';

import 'package:food_app/res/components/components.dart';
import 'package:food_app/res/res.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          const AppbarContainer(),
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  _TitleText(),
                  SearchButton(),
                  ItemListCategories(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TitleText extends StatelessWidget {
  const _TitleText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppText(
      text: 'Deliciosa Comida \npara ti',
      style: AppStyle.instance.h2BoldBlack.copyWith(
        height: 1.2,
      ),
      leftPadding: Dimens.d24,
      topPadding: Dimens.d16,
      bottomPadding: Dimens.d8,
    );
  }
}
