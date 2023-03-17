import 'package:flutter/material.dart';
import 'package:skitmaker/constants/constance.dart';
import 'package:skitmaker/views/screens/auth/login_page.dart';
import 'package:skitmaker/views/widgets/go_back_button.dart';
import 'package:get/get.dart';

import 'package:skitmaker/constants/colors.dart';
import 'package:skitmaker/views/widgets/dont_have_account_text_widget.dart';
import 'package:skitmaker/views/widgets/large_text.dart';
import 'package:skitmaker/views/widgets/primary_button_widget.dart';
import 'package:skitmaker/views/widgets/or_divider_widget.dart';
import 'package:skitmaker/views/widgets/rember_me_checkbox.dart';
import 'package:skitmaker/views/widgets/social_icon.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  doesUserExist(String username) async {
    try {
      await firestore
          .collection('users')
          .where("username", isEqualTo: username)
          .get()
          .then((value) => value.size > 0 ? true : false);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  var formKey = GlobalKey<FormState>();
  var isObscure = true.obs;
  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  // var fullNameController = '';
  // var phoneNumberController = '';
  // var genderController = '';
  // var imageController;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: mainBlack,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.37,
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: Container(
                        width: size.width * 0.5,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("images/skitmaker_icon.png"),
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      top: 220,
                      child: Align(
                        alignment: Alignment.center,
                        child: LargeTextWidget(
                          text: "Create Your Account",
                          textSize: 26,
                          textColor: mainWhite,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 50.0),
                      child: GoBackButtonWidget(),
                    ),
                  ],
                ),
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    // Username
                    TextFormField(
                      controller: usernameController,
                      style: const TextStyle(color: grayWhite),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a username';
                        }

                        if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
                          return 'Please enter a valid username.';
                        }
                      },
                      onEditingComplete: () {
                        print("Pleaseeeeeeeeeeeeeeeee");
                        print(usernameController);
                      },
                      // onChanged: (value) {

                      // },
                      decoration: const InputDecoration(
                        label: Text(
                          'Username',
                          style: TextStyle(color: grayWhite),
                        ),
                        prefixIcon: Icon(
                          Icons.person,
                          color: grayWhite,
                        ),
                        border: OutlineInputBorder(),
                        fillColor: lightBlack,
                        filled: true,
                        hintStyle: TextStyle(color: grayWhite),
                      ),
                    ),
                    const SizedBox(height: 15),
                    // Email
                    TextFormField(
                      controller: emailController,
                      validator: (value) =>
                          value == "" ? "Please enter your email" : null,
                      style: const TextStyle(
                          color: grayWhite, fontWeight: FontWeight.bold),
                      decoration: const InputDecoration(
                        label: Text(
                          'Email',
                          style: TextStyle(color: grayWhite),
                        ),
                        prefixIcon: Icon(
                          Icons.email,
                          color: grayWhite,
                        ),
                        border: OutlineInputBorder(),
                        fillColor: lightBlack,
                        filled: true,
                        hintStyle: TextStyle(color: grayWhite),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Password
                    Obx(
                      () => TextFormField(
                        controller: passwordController,
                        obscureText: isObscure.value,
                        validator: (value) =>
                            value == "" ? "Please enter your password" : null,
                        style: const TextStyle(
                            color: grayWhite, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          label: const Text(
                            'Password',
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
                          border: const OutlineInputBorder(),
                          fillColor: lightBlack,
                          filled: true,
                          hintStyle: const TextStyle(color: grayWhite),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

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
                    const SizedBox(height: 30),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: MainButtomWidget(
                        active: true,
                        btnText: 'Sign Up Now',
                        press: () {
                          authController.registerUser(
                            usernameController.text,
                            emailController.text,
                            passwordController.text,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Center(child: OrDivider(dividerText: "  or continue with ")),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialIcon(
                    image: "images/icons/facebook.png",
                    press: () {},
                  ),
                  const SizedBox(width: 20),
                  SocialIcon(
                    image: "images/icons/google.png",
                    press: () {},
                  ),
                  const SizedBox(width: 20),
                  SocialIcon(
                    image: "images/icons/twitter.png",
                    press: () {},
                  ),
                ],
              ),
              const SizedBox(height: 10),
              DontHaveAccountTextWidget(
                press: () {
                  Get.to(
                    () => const LoginPage(),
                    transition: Transition.leftToRightWithFade,
                    duration: const Duration(seconds: 1),
                  );
                },
                text: "Already have an account?",
                clickableText: "Sign In",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
