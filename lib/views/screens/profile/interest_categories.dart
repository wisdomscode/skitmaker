import 'package:flutter/material.dart';
import 'package:skitmaker/views/screens/profile/update_profile.dart';
import 'package:skitmaker/views/screens/profile/interests_listview_widget.dart';
import 'package:skitmaker/views/widgets/go_back_button.dart';
import 'package:skitmaker/views/widgets/large_text.dart';
import 'package:skitmaker/views/widgets/normal_text.dart';

import 'package:skitmaker/constants/colors.dart';
import 'package:skitmaker/views/widgets/primary_button_widget.dart';
import 'package:skitmaker/views/widgets/secondary_button.dart';
import 'package:get/get.dart';

bool smsSelected = false;
bool emailSelected = false;

class InterestCategoryPage extends StatefulWidget {
  const InterestCategoryPage({super.key});

  @override
  State<InterestCategoryPage> createState() => _InterestCategoryPageState();
}

class _InterestCategoryPageState extends State<InterestCategoryPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: lightBlack,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  const GoBackButtonWidget(),
                  const SizedBox(width: 20),
                  Center(
                    child: LargeTextWidget(
                      text: 'Choose Your Interests',
                      textSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: NormalTextWidget(
                text:
                    "Choose your interests and get the best skits recommendations. Don't worry, you can always change it later!",
                textSize: 18,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: InterestListViewWidget(),
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SecondaryButtomWidget(
                  btnText: 'Skip',
                  buttonWidth: size.width * 0.4,
                  textSize: 16,
                  press: () {
                    Get.back();
                  },
                ),
                // const Spacer(),
                MainButtomWidget(
                  active: true,
                  btnText: 'Continue',
                  buttonWidth: size.width * 0.4,
                  textSize: 16,
                  press: () {
                    // submit selected categories first

                    print('Interest items submitted');
                  },
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
