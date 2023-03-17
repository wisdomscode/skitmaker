import 'package:flutter/material.dart';

class NavigationIconButton extends StatelessWidget {
  const NavigationIconButton({
    Key? key,
    required this.color,
    required this.icon,
    required this.onTapButton,
    required this.iconColor,
  }) : super(key: key);

  final Color color;
  final Function onTapButton;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      elevation: 8,
      borderRadius: BorderRadius.circular(25),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        onTap: () {
          onTapButton();
        },
        splashColor: Colors.white,
        child: SizedBox(
          width: 50,
          height: 50,
          child: Center(
            child: Icon(
              icon,
              color: iconColor,
            ),
          ),
        ),
      ),
    );
  }
}
