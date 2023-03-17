import 'package:flutter/material.dart';
import 'package:skitmaker/constants/colors.dart';

class LargeTextWidget extends StatelessWidget {
  LargeTextWidget({
    Key? key,
    required this.text,
    this.textColor,
    this.textSize,
  }) : super(key: key);

  String text;
  Color? textColor;
  double? textSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: textSize ?? 30,
        fontWeight: FontWeight.bold,
        color: textColor ?? mainWhite,
      ),
    );
  }
}
