import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {
  IconButtonWidget({
    super.key,
    required this.buttonTitle,
    required this.icon,
    required this.onClicked,
  });

  String buttonTitle;
  IconData icon;
  Function onClicked;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(56),
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        textStyle: const TextStyle(fontSize: 20),
      ),
      child: Row(children: [
        Icon(icon, size: 28),
        const SizedBox(width: 15),
        Text(buttonTitle),
      ]),
      onPressed: () {
        onClicked;
      },
    );
  }
}
