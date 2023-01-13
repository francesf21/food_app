import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final double leftPadding;
  final double rightPadding;
  final double bottomPadding;
  final double topPadding;

  const AppText({
    Key? key,
    required this.text,
    required this.style,
    this.leftPadding = 0,
    this.rightPadding = 0,
    this.bottomPadding = 0,
    this.topPadding = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: leftPadding,
        right: rightPadding,
        top: topPadding,
        bottom: bottomPadding,
      ),
      child: Text(
        text,
        style: style.copyWith(
          decoration: TextDecoration.none,
        ),
      ),
    );
  }
}
