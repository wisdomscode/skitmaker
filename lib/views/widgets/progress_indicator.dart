import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(
              backgroundColor: Colors.white,
              strokeWidth: 5,
            ),
            const Padding(padding: EdgeInsets.only(top: 20.0)),
            Image.asset(
              'images/skitmaker_logo.png',
              scale: 0.5,
            ),
          ],
        ),
      ),
    );
  }
}
