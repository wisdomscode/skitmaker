import 'package:flutter/material.dart';
import 'package:skitmaker/constants/colors.dart';

class SecondaryButtomWidget extends StatelessWidget {
  SecondaryButtomWidget({
    super.key,
    required this.btnText,
    required this.press,
    this.buttonWidth,
    this.textSize,
  });

  String btnText;
  final Function press;
  double? buttonWidth;
  double? textSize = 16;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 50,
      width: buttonWidth ?? size.width,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          color: lightBlack),
      child: OutlinedButton(
        onPressed: () {
          press();
        },
        child: Text(
          btnText,
          style: TextStyle(
            color: mainWhite,
            fontSize: textSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
