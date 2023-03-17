import 'package:flutter/material.dart';
import 'package:skitmaker/constants/colors.dart';

class NormalTextWidget extends StatelessWidget {
  NormalTextWidget({
    super.key,
    required this.text,
    this.textColor,
    this.textSize,
  });

  String text;
  Color? textColor;
  double? textSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: textSize ?? 14,
        color: textColor ?? mainWhite,
      ),
    );
  }
}
