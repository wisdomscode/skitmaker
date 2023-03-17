import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:skitmaker/constants/colors.dart';
import 'package:skitmaker/controllers/auth_controller.dart';
import 'package:skitmaker/views/splash/onboarding_page.dart';
import 'package:get/get.dart';

class BoardingSplash extends StatefulWidget {
  const BoardingSplash({super.key});

  @override
  State<BoardingSplash> createState() => _BoardingSplashState();
}

class _BoardingSplashState extends State<BoardingSplash> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    await Firebase.initializeApp().then((value) => {Get.put(AuthController())});
    var duration = const Duration(seconds: 1);
    return Timer(duration, route);
  }

  route() {
    Get.to(
      () => const Onboarding(),
      transition: Transition.fade,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            radius: 0.8,
            colors: [mainYellow, mainRed],
            stops: [0.2, 0.9],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/skitmaker_logo.png',
                scale: 0.5,
              ),
              const Padding(padding: EdgeInsets.only(top: 20.0)),
              const CircularProgressIndicator(
                backgroundColor: Colors.white,
                strokeWidth: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
