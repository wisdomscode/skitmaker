import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:skitmaker/constants/colors.dart';
import 'package:skitmaker/constants/constance.dart';
import 'package:skitmaker/controllers/auth_controller.dart';
import 'package:skitmaker/navigation_container.dart';
import 'package:get/get.dart';
import 'package:skitmaker/views/screens/auth/login_page.dart';
import 'package:skitmaker/views/widgets/progress_indicator.dart';

class HomeSplash extends StatefulWidget {
  const HomeSplash({super.key});

  @override
  State<HomeSplash> createState() => _HomeSplashState();
}

class _HomeSplashState extends State<HomeSplash> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    await Firebase.initializeApp().then((value) => {Get.put(AuthController())});
    var duration = const Duration(seconds: 2);
    return Timer(duration, route);
  }

  var user = firebaseAuth.currentUser;
  route() {
    if (user == null) {
      Get.to(
        () => const LoginPage(),
        transition: Transition.fade,
        duration: const Duration(seconds: 2),
      );
    } else if (user != null) {
      Get.to(
        () => const NavigationContainer(),
        transition: Transition.fade,
        duration: const Duration(seconds: 2),
      );
    } else {
      Get.to(() => const CustomProgressIndicator());
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
