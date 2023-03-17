import 'package:flutter/material.dart';
import 'package:skitmaker/constants/colors.dart';
import 'package:skitmaker/views/widgets/normal_text.dart';

class CustomBottomModalList extends StatelessWidget {
  const CustomBottomModalList({
    Key? key,
    required this.icon,
    required this.text,
    required this.onListTap,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final Function onListTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onListTap();
      },
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20.0, right: 20, bottom: 10, top: 10),
        child: Row(
          children: [
            Icon(icon, color: grayWhite, size: 25),
            const SizedBox(width: 15),
            NormalTextWidget(
              text: text,
              textColor: grayWhite,
              textSize: 18,
            )
          ],
        ),
      ),
    );
  }
}
