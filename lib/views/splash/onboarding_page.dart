import 'package:flutter/material.dart';
import 'package:skitmaker/constants/colors.dart';
import 'package:skitmaker/views/screens/auth/home_page.dart';
import 'package:skitmaker/views/screens/auth/login_page.dart';
import 'package:skitmaker/views/splash/content_model.dart';
import 'package:get/get.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: contents.length,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (_, i) {
                return Stack(
                  children: [
                    Positioned.fill(
                      top: 0,
                      bottom: 200,
                      child: Image.asset(
                        contents[i].image,
                        height: 500,
                        width: double.maxFinite,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned.fill(
                      bottom: 0,
                      child: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('images/bg_bottom_img.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                    contents.length,
                                    (index) => buildDot(index, context),
                                  ),
                                ),
                              ),
                              Text(
                                contents[i].title,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                contents[i].description,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                ),
                              ),
                              Container(
                                height: 50,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 40, horizontal: 20),
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  gradient: LinearGradient(
                                    colors: [mainRed, mainYellow],
                                    stops: [0.4, 0.8],
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    if (currentIndex == contents.length - 1) {
                                      Get.to(
                                        () => const LoginPage(),
                                        transition:
                                            Transition.rightToLeftWithFade,
                                        duration: const Duration(seconds: 3),
                                      );
                                    }
                                    _controller.nextPage(
                                      duration: const Duration(seconds: 1),
                                      curve: Curves.ease,
                                    );
                                  },
                                  child: Text(
                                    currentIndex == contents.length - 1
                                        ? "Get Started"
                                        : 'Next',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 35 : 10,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
