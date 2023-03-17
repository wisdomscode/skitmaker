import 'package:flutter/material.dart';

import 'package:skitmaker/constants/colors.dart';

class ForgetPasswordCodeWidget extends StatelessWidget {
  const ForgetPasswordCodeWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [mainRed, mainYellow]),
      ),
      child: Container(
        width: 46,
        height: 46,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: lightBlack,
        ),
        alignment: Alignment.center,
        child: Center(child: TextField()),
      ),
    );
  }
}
