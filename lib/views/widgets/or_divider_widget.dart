import 'package:flutter/material.dart';
import 'package:skitmaker/constants/colors.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({Key? key, required this.dividerText}) : super(key: key);

  final String dividerText;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.01),
      width: size.width,
      child: Row(
        children: [
          customDivider(),
          Text(
            dividerText,
            style: const TextStyle(
                color: grayWhite, fontWeight: FontWeight.w600, fontSize: 12),
          ),
          customDivider(),
        ],
      ),
    );
  }

  Expanded customDivider() {
    return const Expanded(
      child: Divider(
        color: Color(0xFFC1C1C1),
        thickness: 1.0,
        height: 1.5,
      ),
    );
  }
}
