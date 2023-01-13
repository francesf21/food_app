import 'package:flutter/material.dart';
import 'package:food_app/res/res.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundColor,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
