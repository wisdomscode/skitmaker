import 'package:flutter/material.dart';
import 'package:skitmaker/constants/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialLoginRectangleBtn extends StatelessWidget {
  SocialLoginRectangleBtn({
    Key? key,
    required this.image,
    required this.buttonText,
    required this.press,
  }) : super(key: key);

  String buttonText;
  String image;
  Function press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
          width: size.width,
          height: 50,
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Ink.image(
                  image: AssetImage(image),
                  height: 40,
                  width: 40,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 10),
                Center(
                  child: Text(
                    buttonText,
                    style: TextStyle(fontSize: 16, color: mainWhite),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
