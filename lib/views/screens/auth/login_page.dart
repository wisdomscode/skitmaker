import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:skitmaker/constants/constance.dart';
import 'package:skitmaker/navigation_container.dart';
import 'package:skitmaker/provider/internet_provider.dart';
import 'package:skitmaker/provider/social_signin_provider.dart';
import 'package:skitmaker/views/screens/auth/register_page.dart';
import 'package:skitmaker/views/screens/forgot_password/reset_password_page.dart';
import 'package:skitmaker/views/widgets/go_back_button.dart';
import 'package:get/get.dart';

import 'package:skitmaker/constants/colors.dart';
import 'package:skitmaker/views/widgets/dont_have_account_text_widget.dart';
import 'package:skitmaker/views/widgets/large_text.dart';
import 'package:skitmaker/views/widgets/primary_button_widget.dart';
import 'package:skitmaker/views/widgets/or_divider_widget.dart';
import 'package:skitmaker/views/widgets/rember_me_checkbox.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var formKey = GlobalKey<FormState>();
  final RoundedLoadingButtonController googleController =
      RoundedLoadingButtonController();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isObscure = true.obs;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: mainBlack,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                      top: 200,
                      child: Align(
                        alignment: Alignment.center,
                        child: LargeTextWidget(
                          text: "Login to your Account",
                          textSize: 20,
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
              RoundedLoadingButton(
                controller: googleController,
                onPressed: () {
                  handleGoogleLogin();
                },
                successColor: mainRed,
                color: mainRed,
                width: MediaQuery.of(context).size.width,
                elevation: 0,
                borderRadius: 25,
                child: Wrap(
                  children: const [
                    Icon(
                      FontAwesomeIcons.google,
                      size: 20,
                      color: mainWhite,
                    ),
                    SizedBox(width: 15),
                    Text(
                      "Continue with Google",
                      style: TextStyle(
                        color: mainWhite,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Center(
                  child:
                      OrDivider(dividerText: "  or with email and password ")),
              const SizedBox(height: 10),
              Form(
                key: formKey,
                child: Column(
                  children: [
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
                    const SizedBox(height: 10),

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

                    // reusable custom checkbox
                    RememberMeCheckox(
                      size: 20,
                      checkSize: 17,
                      isChecked: false,
                      selectedColor: mainRed,
                      selectedCheckColor: mainWhite,
                      textLabel: "Remember Me",
                      textColor: mainWhite,
                      textSize: 14,
                    ),
                    const SizedBox(height: 25),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: MainButtomWidget(
                        active: true,
                        btnText: 'Login',
                        press: () {
                          authController.loginUser(
                              emailController.text, passwordController.text);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    Get.to(
                      () => const ForgetPasswordPage(),
                      transition: Transition.leftToRightWithFade,
                      duration: const Duration(seconds: 1),
                    );
                  },
                  child: const Text(
                    "Forgot your Password?",
                    style: TextStyle(
                      color: mainRed,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              DontHaveAccountTextWidget(
                press: () {
                  Get.to(
                    () => const RegisterPage(),
                    transition: Transition.leftToRightWithFade,
                    duration: const Duration(seconds: 1),
                  );
                },
                text: "Don't have an Account?",
                clickableText: "Register",
              ),
            ],
          ),
        ),
      ),
    );
  }

  // handle Google login
  Future handleGoogleLogin() async {
    final sp = context.read<SignInProvider>();
    final ip = context.read<InternetProvideer>();

    await ip.checkInternetConnection();

    if (ip.hasInternet == false) {
      Get.snackbar(
        'Internet Error',
        'Check your Internet connection',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 10),
        colorText: mainWhite,
      );
      googleController.reset();
    } else {
      await sp.signInWithGoogle().then((value) {
        if (sp.hasError == true) {
          Get.snackbar(
            'Error Signing in',
            'Something went wrong',
            // sp.errorCode.toString(),
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 10),
            colorText: mainWhite,
          );
          googleController.reset();
        } else {
          // check if the user exist or not
          sp.checkUserExists().then((value) async {
            if (value == true) {
              // user exists

            } else {
              // user does not exist

              // sp.saveUserDataToCloudFirestore().then(
              //       (value) => sp.setSignedIn().then((value) {
              //         googleController.success();
              //         handleAfterSignin();
              //       }),
              //     );

              sp.saveUserDataToCloudFirestore().then((value) {
                googleController.success();
                handleAfterSignin();
              });
            }
          });
        }
      });
    }
  }

  handleAfterSignin() {
    Get.to(
      () => const NavigationContainer(),
      duration: const Duration(seconds: 1),
      transition: Transition.leftToRightWithFade,
    );
  }
}
