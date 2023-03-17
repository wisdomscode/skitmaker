import 'package:flutter/material.dart';
import 'package:skitmaker/views/screens/forgot_password/otp_code.dart';
import 'package:skitmaker/views/widgets/go_back_button.dart';
import 'package:skitmaker/views/widgets/main_box_widget.dart';
import 'package:skitmaker/views/widgets/normal_text.dart';

import 'package:skitmaker/constants/colors.dart';
import 'package:skitmaker/views/widgets/primary_button_widget.dart';
import 'package:get/get.dart';

bool smsSelected = false;
bool emailSelected = false;

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBlack,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const GoBackButtonWidget(),
              Container(
                height: 250,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/forget_password.png'),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              NormalTextWidget(
                text:
                    "Select which contact details we should use to reset your password",
              ),
              const SizedBox(height: 30),
              MainBoxWidget(
                getSelectedItem: () {
                  print('SMS selected');
                },
                isSelectedBox: false,
                icon: Icons.chat,
                viaText: 'Via SMS',
                detailText: '+234 8054 345 ***789',
              ),
              const SizedBox(height: 30),
              MainBoxWidget(
                getSelectedItem: () {
                  print('Email selected');
                },
                isSelectedBox: false,
                icon: Icons.email,
                viaText: 'Via Email',
                detailText: 'wisdom@gmail.com',
              ),
              const SizedBox(height: 30),
              MainButtomWidget(
                active: true,
                btnText: 'Request Code',
                press: () {
                  Get.to(
                    () => OtpCodes(),
                    transition: Transition.leftToRightWithFade,
                    duration: Duration(seconds: 1),
                  );
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
