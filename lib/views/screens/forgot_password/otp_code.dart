import 'package:flutter/material.dart';
import 'package:skitmaker/constants/colors.dart';
import 'package:skitmaker/views/screens/forgot_password/create_new_password.dart';
import 'package:skitmaker/views/widgets/go_back_button.dart';
import 'package:skitmaker/views/widgets/large_text.dart';
import 'package:skitmaker/views/widgets/primary_button_widget.dart';
import 'package:skitmaker/views/widgets/normal_text.dart';
import 'package:get/get.dart';

class OtpCodes extends StatefulWidget {
  const OtpCodes({super.key});

  @override
  State<OtpCodes> createState() => _OtpCodesState();
}

class _OtpCodesState extends State<OtpCodes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBlack,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const GoBackButtonWidget(),
                ],
              ),
              const SizedBox(height: 50),
              Center(
                child: LargeTextWidget(
                  text: 'Code has been sent to',
                  textSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: LargeTextWidget(
                  text: '234 803 74***89',
                  textSize: 20,
                ),
              ),
              const SizedBox(height: 50),
              Center(
                child: NormalTextWidget(
                  text: "Enter Code Sent to Your Phone or Email",
                  textSize: 16,
                ),
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _textFieldOTP(first: true, last: false),
                  _textFieldOTP(first: false, last: false),
                  _textFieldOTP(first: false, last: false),
                  _textFieldOTP(first: false, last: true),
                ],
              ),
              const SizedBox(height: 20),
              RichText(
                textScaleFactor: 1,
                text: const TextSpan(
                  text: 'Sent Code expires in ',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  children: <TextSpan>[
                    TextSpan(
                        text: '4.35',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.deepOrange)),
                    TextSpan(
                        text: ' min',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              MainButtomWidget(
                active: true,
                btnText: 'Verify',
                press: () {
                  Get.to(
                    () => const CreateNewPasswordPage(),
                    transition: Transition.leftToRightWithFade,
                    duration: const Duration(seconds: 1),
                  );
                },
              ),
              const SizedBox(height: 30),
              NormalTextWidget(
                text: "Didn't receive any code?",
                textSize: 16,
              ),
              const SizedBox(height: 15),
              TextButton(
                onPressed: () {
                  print('resend OTP');
                },
                child: LargeTextWidget(
                  text: "Resend New Code",
                  textSize: 20,
                  textColor: Colors.deepOrange,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _textFieldOTP({required bool first, last}) {
    return Container(
      height: 85,
      child: AspectRatio(
        aspectRatio: 0.7,
        child: TextField(
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.length == 0 && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 24, color: mainWhite),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: const Offstage(),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 2, color: Colors.grey),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 4, color: Colors.deepOrange),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}
