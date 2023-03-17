import 'package:flutter/material.dart';
import 'package:skitmaker/constants/colors.dart';

class CircularGradientIconWidget extends StatelessWidget {
  CircularGradientIconWidget({
    Key? key,
    this.outerBorderHeight,
    this.outerBorderWidth,
    this.innerBorderHeight,
    this.innerBorderWidth,
    required this.icon,
    this.IconSize,
  }) : super(key: key);

  double? outerBorderHeight, outerBorderWidth;
  double? innerBorderHeight, innerBorderWidth;

  IconData icon;
  double? IconSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: outerBorderHeight ?? 48,
      width: outerBorderWidth ?? 48,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [mainRed, mainYellow],
        ),
        shape: BoxShape.circle,
      ),
      child: Center(
          child: Container(
        height: innerBorderHeight ?? 42,
        width: innerBorderWidth ?? 42,
        decoration: const BoxDecoration(
          color: mainBlack,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: mainWhite, size: IconSize ?? 25),
      )),
    );
  }
}
