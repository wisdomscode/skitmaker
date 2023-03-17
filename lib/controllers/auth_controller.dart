import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:skitmaker/constants/colors.dart';
import 'package:skitmaker/constants/constance.dart';

import 'package:skitmaker/models/user_model.dart' as user_model;
import 'package:skitmaker/navigation_container.dart';
import 'package:skitmaker/views/screens/auth/home_page.dart';
import 'package:skitmaker/views/screens/auth/login_page.dart';
import 'package:skitmaker/views/screens/profile/update_user_profile.dart';

class AuthController extends GetxController {
  // to get the AuthController and return its instance
  static AuthController instance = Get.find();

  // Observable retain logged in instance
  late Rx<User?> _user;

  User get user => _user.value!;
  DateTime dob = DateTime.now();

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => const LoginPage());
    } else {
      Get.offAll(() => const NavigationContainer());
    }
  }

  // void sendOtp(email) async{
  //   print(email);
  //   EmailAuth.sessionName = 'Sample Session';
  //   var result = await EmailAuth.sendOtp(
  //     receiverMail: email);
  //   if(result) {
  //     print(result);
  //     print('OTP Sent');
  //     print(email);
  //     Get.to(
  //         () => const InterestCategoryPage(),
  //         arguments: (email),
  //         transition: Transition.circularReveal,
  //         duration: const Duration(seconds: 1),
  //       );
  //   }else {
  //     print('Could not Send OTP');
  //   }
  // }

  // void verifyOtp() {
  //   var res = EmailAuth.validate(
  //     receiverMail: receiverMail,
  //     userOTP: userOTP,
  //   );
  //   if (res) {
  //     print('OTP verified');
  //   }else {
  //     print('Invalid OTP');
  //   }
  // }

  // register the user
  void registerUser(
    String username,
    String email,
    String password,
  ) async {
    try {
      if (username.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
        // save user to auth and firebase
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        user_model.User user = user_model.User(
            uid: cred.user!.uid,
            username: username,
            email: email,
            password: password,
            fullName: '',
            dob: dob,
            phoneNumber: '',
            gender: '',
            profileImage: '');

        await firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());

        Get.to(() => const UpdateUserProfilePage(),
            arguments: [
              {'uid': cred.user!.uid},
              {"username": username},
              {"email": email},
              {"fullName": ''},
              {"dob": ''},
              {"phoneNumber": ''},
              {"gender": ''},
              {"profileImage": ''},
            ],
            transition: Transition.leftToRightWithFade,
            duration: const Duration(seconds: 1));
      } else {
        Get.snackbar(
          'Error Creating Account',
          'Please enter all the mandatory fields',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
          colorText: mainWhite,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error Creating Account',
        // e.toString(),
        "Invalid username or password",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        colorText: mainWhite,
      );
    }
  }

  // LOGIN
  void loginUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        print('User LOGGING IN Successfully!!!!');

        Get.to(
          () => const NavigationContainer(),
          transition: Transition.fade,
          duration: const Duration(seconds: 1),
        );
      } else {
        Get.snackbar(
          'Error Logining in',
          'Please check you credentials',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
          colorText: mainWhite,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error Logining In',
        // e.toString(),
        "Invalid username or password",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        colorText: mainWhite,
      );
    }
  }

  // UPDATE Profile
  void updateProfile(
      String username,
      String email,
      String? fullName,
      DateTime? dob,
      String? phoneNumber,
      String? gender,
      String? profileImageUrl) async {
    try {
      if (username.isNotEmpty && email.isNotEmpty) {
        String uid = firebaseAuth.currentUser!.uid; // get currentUser id
        DocumentSnapshot userDoc =
            await firestore.collection('users').doc(uid).get();

        user_model.User user = user_model.User(
            uid: uid,
            username: username,
            email: (userDoc.data()! as Map<String, dynamic>)['email'],
            password: (userDoc.data()! as Map<String, dynamic>)['password'],
            fullName: fullName,
            dob: dob,
            gender: gender,
            phoneNumber: phoneNumber,
            profileImage: profileImageUrl);

        await firestore.collection('users').doc(uid).set(user.toJson());

        Get.snackbar(
          'Success',
          'Profile Updated Successfully',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
          colorText: mainWhite,
        );

        Get.to(
          () => const NavigationContainer(),
          transition: Transition.leftToRightWithFade,
          duration: const Duration(
            seconds: 1,
          ),
        );
      } else {
        Get.snackbar(
          'Error Updating Profile1',
          'Please check your fields',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
          colorText: mainWhite,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error Updating Profile2',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        colorText: mainWhite,
      );
    }
  }

  final GoogleSignIn googleSignIn = GoogleSignIn();

  // logout function
  void logout() async {
    await firebaseAuth.signOut();
    await googleSignIn.signOut();
    Get.to(
      () => const LoginPage(),
      transition: Transition.zoom,
      duration: const Duration(seconds: 3),
    );
  }
}
