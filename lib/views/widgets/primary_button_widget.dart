import 'package:flutter/material.dart';
import 'package:skitmaker/constants/colors.dart';

class MainButtomWidget extends StatelessWidget {
  MainButtomWidget({
    super.key,
    required this.btnText,
    required this.press,
    this.buttonWidth,
    this.textSize,
    required this.active,
  });

  String btnText;
  final Function press;
  double? buttonWidth;
  double? textSize;
  bool active = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: 50,
      width: buttonWidth ?? size.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        gradient: LinearGradient(
          colors: [mainRed, mainYellow],
          stops: [0.4, 0.8],
        ),
      ),
      child: TextButton(
        onPressed: () {
          active ? {press()} : null;
        },
        child: Text(
          btnText,
          style: TextStyle(
            color: active ? mainWhite : Colors.grey.shade700,
            fontSize: textSize ?? 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
