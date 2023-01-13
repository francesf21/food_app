import 'package:flutter/material.dart';

class LogoImage extends StatelessWidget {
  final double height;
  final String image;

  const LogoImage({
    Key? key,
    required this.image,
    this.height = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height * .20,
      child: Image.asset(
        image,
        fit: BoxFit.cover,
      ),
    );
  }
}
