import 'package:flutter/material.dart';

import 'package:skitmaker/constants/colors.dart';
import 'package:skitmaker/views/widgets/go_back_button.dart';
import 'package:skitmaker/views/widgets/large_text.dart';
import 'package:skitmaker/views/widgets/primary_button_widget.dart';
import 'package:skitmaker/views/widgets/rember_me_checkbox.dart';
import 'package:get/get.dart';

class CreateNewPasswordPage extends StatefulWidget {
  const CreateNewPasswordPage({super.key});

  @override
  State<CreateNewPasswordPage> createState() => _CreateNewPasswordPageState();
}

class _CreateNewPasswordPageState extends State<CreateNewPasswordPage> {
  var formKey = GlobalKey<FormState>();
  var newPasswordController = TextEditingController();
  var confirmNewPasswordController = TextEditingController();
  var isObscure = true.obs;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: mainBlack,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.5,
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: Container(
                        width: size.width * 0.5,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("images/create_new_password.png"),
                            // fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      top: 250,
                      child: Align(
                        alignment: Alignment.center,
                        child: LargeTextWidget(
                          text: "Create a New Password",
                          textSize: 20,
                          textColor: mainWhite,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: const GoBackButtonWidget(),
                    ),
                  ],
                ),
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    // New Password
                    Obx(
                      () => TextFormField(
                        controller: newPasswordController,
                        obscureText: isObscure.value,
                        validator: (value) =>
                            value == "" ? "Please enter your password" : null,
                        style: const TextStyle(
                            color: grayWhite, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          label: const Text(
                            'New Password',
                            style: TextStyle(color: grayWhite),
                          ),
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: grayWhite,
                          ),
                          suffixIcon: Obx(
                            () => GestureDetector(
                              onTap: () {
                                isObscure.value = !isObscure.value;
                              },
                              child: Icon(
                                isObscure.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: grayWhite,
                              ),
                            ),
                          ),
                          border: OutlineInputBorder(),
                          fillColor: lightBlack,
                          filled: true,
                          hintText: 'New Password',
                          hintStyle: TextStyle(color: grayWhite),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    // Confirm New password
                    Obx(
                      () => TextFormField(
                        controller: confirmNewPasswordController,
                        obscureText: isObscure.value,
                        validator: (value) =>
                            value == "" ? "Please enter your password" : null,
                        style: const TextStyle(
                            color: grayWhite, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          label: const Text(
                            'Confirm New Password',
                            style: TextStyle(color: grayWhite),
                          ),
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: grayWhite,
                          ),
                          suffixIcon: Obx(
                            () => GestureDetector(
                              onTap: () {
                                isObscure.value = !isObscure.value;
                              },
                              child: Icon(
                                isObscure.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: grayWhite,
                              ),
                            ),
                          ),
                          border: OutlineInputBorder(),
                          fillColor: lightBlack,
                          filled: true,
                          hintText: 'Confirm New Password',
                          hintStyle: TextStyle(color: grayWhite),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),

                    // reusable custom checkbox
                    RememberMeCheckox(
                      size: 20,
                      checkSize: 17,
                      isChecked: false,
                      selectedColor: mainRed,
                      selectedCheckColor: mainWhite,
                      textLabel: "Rembemer Me ",
                      textColor: mainWhite,
                      textSize: 16,
                    ),
                    const SizedBox(height: 40),

                    MainButtomWidget(
                      active: true,
                      btnText: 'Change Password',
                      press: () {
                        print("New Password button clicked");
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
