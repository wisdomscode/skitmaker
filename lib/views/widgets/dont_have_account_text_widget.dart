import 'package:flutter/material.dart';
import 'package:skitmaker/constants/colors.dart';

class DontHaveAccountTextWidget extends StatelessWidget {
  const DontHaveAccountTextWidget({
    Key? key,
    required this.press,
    required this.text,
    required this.clickableText,
  }) : super(key: key);

  final String text;
  final String clickableText;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: const TextStyle(
            color: mainWhite,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          onPressed: () {
            press();
          },
          child: Text(
            clickableText,
            style: const TextStyle(
              color: mainRed,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
