// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:rounded_loading_button/rounded_loading_button.dart';
// import 'package:skitmaker/constants/colors.dart';
// import 'package:skitmaker/controllers/auth_controller.dart';
// import 'package:skitmaker/navigation_container.dart';
// import 'package:skitmaker/provider/internet_provider.dart';
// import 'package:skitmaker/provider/social_signin_provider.dart';
// import 'package:skitmaker/views/screens/auth/login_page.dart';
// import 'package:skitmaker/views/screens/auth/register_page.dart';
// import 'package:skitmaker/views/widgets/dont_have_account_text_widget.dart';
// import 'package:skitmaker/views/widgets/large_text.dart';
// import 'package:skitmaker/views/widgets/primary_button_widget.dart';
// import 'package:skitmaker/views/widgets/or_divider_widget.dart';
// import 'package:get/get.dart';
// import 'package:provider/provider.dart';
// import 'package:skitmaker/views/widgets/social_icon.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   // init state
//   // @override
//   // void initState() {
//   //   final sp = context.read<SignInProvider>();
//   //   super.initState();
//   // }

//   // AuthController authController = Get.find<AuthController>();

//   final GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();
//   final RoundedLoadingButtonController googleController =
//       RoundedLoadingButtonController();
//   final RoundedLoadingButtonController facebookController =
//       RoundedLoadingButtonController();

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       key: _scaffoldKey,
//       backgroundColor: mainBlack,
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 30.0),
//           child: Column(
//             children: [
//               Container(
//                 height: size.height * 0.4,
//                 decoration: const BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage('images/walkin.png'),
//                   ),
//                 ),
//               ),
//               LargeTextWidget(
//                 text: "Let's you in",
//                 textSize: 30,
//                 textColor: mainWhite,
//               ),
//               const SizedBox(height: 20),
//               // SocialLoginRectangleBtn(
//               //   image: "images/icons/facebook.png",
//               //   buttonText: "Continue with Facebook",
//               //   press: () {},
//               // ),
//               // const SizedBox(height: 10),
//               // SocialLoginRectangleBtn(
//               //   buttonText: 'Continue with Google',
//               //   image: "images/icons/google.png",
//               //   press: () {},
//               // ),
//               // const SizedBox(height: 10),
//               // SocialLoginRectangleBtn(
//               //   buttonText: 'Continue with Twitter',
//               //   image: "images/icons/twitter.png",
//               //   press: () {},
//               // ),
//               RoundedLoadingButton(
//                 controller: googleController,
//                 onPressed: () {
//                   handleGoogleLogin();
//                 },
//                 successColor: mainRed,
//                 color: mainRed,
//                 width: MediaQuery.of(context).size.width,
//                 elevation: 0,
//                 borderRadius: 25,
//                 child: Wrap(
//                   children: const [
//                     Icon(
//                       FontAwesomeIcons.google,
//                       size: 20,
//                       color: mainWhite,
//                     ),
//                     SizedBox(width: 15),
//                     Text(
//                       "Continue with Google",
//                       style: TextStyle(
//                         color: mainWhite,
//                         fontSize: 15,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 10),
//               RoundedLoadingButton(
//                 controller: facebookController,
//                 onPressed: () {
//                   // handleFaceBookLogin();
//                 },
//                 successColor: Colors.blue,
//                 color: Colors.blue,
//                 width: MediaQuery.of(context).size.width,
//                 elevation: 0,
//                 borderRadius: 25,
//                 child: Wrap(
//                   children: const [
//                     Icon(
//                       FontAwesomeIcons.facebook,
//                       size: 20,
//                       color: mainWhite,
//                     ),
//                     SizedBox(width: 15),
//                     Text(
//                       "Continue with Facebook",
//                       style: TextStyle(
//                         color: mainWhite,
//                         fontSize: 15,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     )
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 20),
//               OrDivider(dividerText: "  or  "),
//               const SizedBox(height: 20),
//               MainButtomWidget(
//                 active: true,
//                 btnText: 'Sign in with password',
//                 press: () {
//                   Get.to(
//                     () => LoginPage(),
//                     transition: Transition.rightToLeftWithFade,
//                     duration: Duration(seconds: 1),
//                   );
//                 },
//               ),
//               const SizedBox(height: 8),
//               DontHaveAccountTextWidget(
//                 press: () {
//                   Get.to(
//                     () => RegisterPage(),
//                     transition: Transition.leftToRightWithFade,
//                     duration: Duration(seconds: 1),
//                   );
//                 },
//                 text: "Don't have an account?",
//                 clickableText: "Sign Up",
//               ),

//               Center(child: OrDivider(dividerText: "  or continue with ")),
//               const SizedBox(height: 20),
//               // social login
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SocialIcon(
//                     image: "images/icons/facebook.png",
//                     press: () {},
//                   ),
//                   const SizedBox(width: 20),
//                   SocialIcon(
//                     image: "images/icons/google.png",
//                     press: () {},
//                   ),
//                   const SizedBox(width: 10),
//                   SocialIcon(
//                     image: "images/icons/twitter.png",
//                     press: () {},
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

// // handle Google login
//   Future handleGoogleLogin() async {
//     final sp = context.read<SignInProvider>();
//     final ip = context.read<InternetProvideer>();

//     await ip.checkInternetConnection();

//     if (ip.hasInternet == false) {
//       Get.snackbar(
//         'Internet Error',
//         'Check your Internet connection',
//         snackPosition: SnackPosition.BOTTOM,
//         duration: const Duration(seconds: 10),
//         colorText: mainWhite,
//       );
//       googleController.reset();
//     } else {
//       await sp.signInWithGoogle().then((value) {
//         if (sp.hasError == true) {
//           Get.snackbar(
//             'Error Signing in',
//             sp.errorCode.toString(),
//             snackPosition: SnackPosition.BOTTOM,
//             duration: const Duration(seconds: 10),
//             colorText: mainWhite,
//           );
//           googleController.reset();
//         } else {
//           // check if the user exist or not
//           sp.checkUserExists().then((value) async {
//             if (value == true) {
//               // user exists

//             } else {
//               // user does not exist

//               sp.saveUserDataToCloudFirestore().then(
//                     (value) => sp.setSignedIn().then((value) {
//                       googleController.success();
//                       handleAfterSignin();
//                     }),
//                   );
//             }
//           });
//         }
//       });
//     }
//   }

// // handle Facebook login
//   // Future handleFaceBookLogin() async {
//   //   final sp = context.read<SignInProvider>();
//   //   final ip = context.read<InternetProvideer>();

//   //   await ip.checkInternetConnection();

//   //   if (ip.hasInternet == false) {
//   //     print("##################################################");
//   //     print("Internet Error");
//   //     print("##################################################");
//   //     Get.snackbar(
//   //       'Internet Error',
//   //       'Check your Internet connection',
//   //       snackPosition: SnackPosition.BOTTOM,
//   //       duration: const Duration(seconds: 10),
//   //       colorText: mainWhite,
//   //     );
//   //     facebookController.reset();
//   //   } else {
//   //     await sp.signInWithFacebook().then((value) {
//   //       if (sp.hasError == true) {
//   //         print("##################################################");
//   //         print("FaceBook SignIn Error");
//   //         print("##################################################");
//   //         Get.snackbar(
//   //           'Error Signing in',
//   //           sp.errorCode.toString(),
//   //           snackPosition: SnackPosition.BOTTOM,
//   //           duration: const Duration(seconds: 10),
//   //           colorText: mainWhite,
//   //         );
//   //         facebookController.reset();
//   //       } else {
//   //         // check if the user exist or not

//   //         sp.checkUserExists().then((value) async {
//   //           if (value == true) {
//   //             // user exists
//   //             print("##################################################");
//   //             print("User Exists");
//   //             print("##################################################");
//   //             // await sp.getUserDataFromCloudFirestore(sp.uid).then((value) => sp
//   //             //     .saveToSharedPreferences()
//   //             //     .then((value) => sp.setSignedIn().then((value) {
//   //             //           facebookController.success();
//   //             //           handleAfterSignin();
//   //             //         })));

//   //             // sp.setSignedIn().then((value) {
//   //             //   facebookController.success();
//   //             //   handleAfterSignin();
//   //             // });
//   //             print("##################################################");
//   //             print("SignIn Done");
//   //             print("##################################################");
//   //           } else {
//   //             // user does not exist
//   //             print('#############################################');
//   //             print("User Does Not Exists");
//   //             print('#############################################');
//   //             sp.saveUserDataToCloudFirestore().then(
//   //                   (value) => sp.setSignedIn().then((value) {
//   //                     facebookController.success();
//   //                     handleAfterSignin();
//   //                   }),
//   //                 );

//   //             // sp.saveUserDataToCloudFirestore().then(
//   //             //       (value) => sp.saveToSharedPreferences().then(
//   //             //             (value) => sp.setSignedIn().then((value) {
//   //             //               facebookController.success();
//   //             //               handleAfterSignin();
//   //             //             }),
//   //             //           ),
//   //             //     );
//   //           }
//   //         });
//   //       }
//   //     });
//   //   }
//   // }

//   //  handle After Signin
//   handleAfterSignin() {
//     Get.to(
//       () => const NavigationContainer(),
//       duration: const Duration(seconds: 1),
//       transition: Transition.leftToRightWithFade,
//     );
//   }

//   // // Sign in with Facebook
//   // Future signInWithFacebook() async {
//   //   final LoginResult result = await facebookAuth.login();
//   //   // to get the profile from Facebook graph API
//   //   final graphResponse = await http.get(Uri.parse(
//   //       'https://graph.facebook.com/v2.12/me?fields=name,picture.width(200).height(200),first_name,last_name,email&access_token=${result.accessToken!.token}'));

//   //   final profile = jsonDecode(graphResponse.body);

//   //   if (result.status == LoginStatus.success) {
//   //     try {
//   //       final OAuthCredential credential =
//   //           FacebookAuthProvider.credential(result.accessToken!.token);
//   //       await firebaseAuth.signInWithCredential(credential);

//   //       // get username from email
//   //       String newEmail = profile['email'];

//   //       String? usernameFromEmail =
//   //           newEmail.substring(0, newEmail.indexOf("@"));

//   //       // saving user details to firebase
//   //       _uid = profile['id'];
//   //       _fullName = profile['name'];
//   //       _email = profile['email'];
//   //       _profileImage = profile['picture']['data']['url'];
//   //       _provider = "FACEBOOK";
//   //       _phoneNumber = '';
//   //       _gender = '';
//   //       _username = usernameFromEmail;
//   //       _dob = defaultDate;
//   //       _hasError = false;

//   //       _isSignedIn = true;

//   //       notifyListeners();
//   //     } on FirebaseAuthException catch (e) {
//   //       switch (e.code) {
//   //         case "account-exists-with-different-credential":
//   //           _errorCode =
//   //               "You already have an account with us. Use correct provider";
//   //           _hasError = true;
//   //           notifyListeners();

//   //           break;
//   //         case "user-disabled":
//   //           _errorCode = "Your account is disabled. Contact the Admin.";
//   //           _hasError = true;
//   //           notifyListeners();
//   //           break;
//   //         case "user-not-found":
//   //           _errorCode =
//   //               "You DO NOT have an account with us. Create an account first.";
//   //           _hasError = true;
//   //           notifyListeners();
//   //           break;
//   //         case "null":
//   //           _errorCode = "Some unexpected errors while trying to sign in.";
//   //           _hasError = true;
//   //           notifyListeners();
//   //           break;
//   //         default:
//   //           _errorCode = "Default error -- " + e.toString();
//   //           _hasError = true;
//   //           notifyListeners();
//   //       }
//   //     }
//   //   } else {
//   //     _hasError = true;
//   //     notifyListeners();
//   //   }
//   // }

//   // Future signInWithFacebook() async {
//   //   try {
//   //     final result =
//   //         await FacebookAuth.i.login(permissions: ['pubic_profile', 'email']);
//   //     if (result.status == LoginStatus.success) {
//   //       final userData = await FacebookAuth.i.getUserData();
//   //       print('facebook user data:- ');
//   //       print(userData);

//   //       final name = userData["name"];
//   //       final first_name = userData["first_name"];
//   //       final last_name = userData["last_name"];
//   //       final email = userData["email"];
//   //       final profileImage = userData["picture"]['data']['url'];

//   //       Get.to(() => const HomePage(),
//   //           arguments: [
//   //             {'userDate': userData}
//   //           ],
//   //           transition: Transition.leftToRightWithFade,
//   //           duration: const Duration(seconds: 1));
//   //     }
//   //   } catch (e) {
//   //     print(e);
//   //   }
//   // }

//   // // to save data to shareedPreferences
//   // Future saveToSharedPreferences() async {
//   //   final SharedPreferences sharedPreferences =
//   //       await SharedPreferences.getInstance();
//   //   await sharedPreferences.setString('fullName', _fullName!);
//   //   await sharedPreferences.setString('email', _email!);
//   //   await sharedPreferences.setString('uid', _uid!);
//   //   await sharedPreferences.setString('profileImage', _profileImage!);
//   //   await sharedPreferences.setString('provider', _provider!);
//   //   await sharedPreferences.setString('phoneNumber', _phoneNumber!);
//   //   await sharedPreferences.setString('gender', _gender!);
//   //   await sharedPreferences.setString('username', _username!);
//   // }

//   // // logout function
//   // void logout() async {
//   //   await firebaseAuth.signOut();
//   //   await googleSignIn.signOut();
//   //   await FacebookAuth.i.logOut();
//   //   Get.to(
//   //     () => const LoginPage(),
//   //     transition: Transition.zoom,
//   //     duration: const Duration(seconds: 1),
//   //   );

//   //   // clear the all stored data
//   //   // clearStoredData();
//   // }

//   // // clear all data in SharedPreferences
//   // Future clearStoredData() async {
//   //   final SharedPreferences s = await SharedPreferences.getInstance();
//   //   s.clear();
//   // }

//   //   SignInProvider() {
//   //   checkSignInUser();
//   // }

//   // Future checkSignInUser() async {
//   //   final SharedPreferences sharedPreferences =
//   //       await SharedPreferences.getInstance();
//   //   _isSignedIn = sharedPreferences.getBool("signed_in") ?? false;
//   //   notifyListeners();
//   // }

//   // set signed in to true
//   // Future setSignedIn() async {
//   //   final SharedPreferences sharedPreferences =
//   //       await SharedPreferences.getInstance();
//   //   sharedPreferences.setBool("signed_in", true);
//   //   _isSignedIn = true;
//   //   notifyListeners();
//   // }
// }
