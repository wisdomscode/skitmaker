import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skitmaker/constants/colors.dart';

class SocialIcon extends StatelessWidget {
  String image;
  Function press;

  SocialIcon({
    Key? key,
    required this.image,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: lightBlack,
      elevation: 8,
      borderRadius: BorderRadius.circular(10),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        onTap: () {
          press();
        },
        splashColor: Colors.white,
        child: SizedBox(
          width: 50,
          height: 50,
          child: Center(
            child: Ink.image(
              image: AssetImage(image),
              height: 40,
              width: 40,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
