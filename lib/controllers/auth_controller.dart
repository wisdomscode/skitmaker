import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:skitmaker/constants/colors.dart';
import 'package:skitmaker/constants/constance.dart';

import 'package:skitmaker/models/user_model.dart' as user_model;
import 'package:skitmaker/navigation_container.dart';
import 'package:skitmaker/views/screens/auth/login_page.dart';
import 'package:skitmaker/views/screens/profile/profile_page.dart';
import 'package:skitmaker/views/screens/profile/update_profile.dart';

class AuthController extends GetxController {
  // to get the AuthController and return its instance
  static AuthController instance = Get.find();

  // Observable retain logged in instance
  late Rx<User?> _user;

  User get user => _user.value!;

  DateTime date = DateTime.now();

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
    String email,
    String password,
  ) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        // save user to auth and firebase
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // to get the last user id
        int lastuserId = await firestore
            .collection('users')
            .orderBy("dateJoined", descending: true)
            .limit(1)
            .get()
            .then((QuerySnapshot querySnapshot) {
          var data = querySnapshot.docs.first.data() as Map;

          var userId = data['userId'];
          return userId;
        });

        user_model.User user = user_model.User(
          uid: cred.user!.uid,
          userId: lastuserId + 1,
          userStatus: 'active',
          dateJoined: Timestamp.fromDate(date),
          username: '',
          email: email,
          password: password,
          fullName: '',
          dob: Timestamp.fromDate(date),
          phoneNumber: '',
          gender: '',
          profileImage: '',
          biography: '',
        );

        await firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());

        Get.to(() => const UpdateUserProfilePage(),
            arguments: [
              {'uid': cred.user!.uid},
              {"username": ''},
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
          'Error!',
          'Please fillout all the fields',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
          colorText: mainWhite,
        );
        Get.back();
      }
    } catch (e) {
      Get.snackbar(
        'Error Creating Account',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        colorText: mainWhite,
      );
      Get.back();
    }
  }

  // LOGIN
  void loginUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        // print('User LOGGING IN Successfully!!!!');

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
        Get.back();
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
      Get.back();
    }
  }

  // UPDATE Profile
  void updateProfile(
      String username,
      String email,
      String? fullName,
      DateTime dob,
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
          userId: (userDoc.data()! as Map<String, dynamic>)['userId'],
          userStatus: (userDoc.data()! as Map<String, dynamic>)['userStatus'],
          dateJoined: (userDoc.data()! as Map<String, dynamic>)['dateJoined'],
          username: username,
          email: (userDoc.data()! as Map<String, dynamic>)['email'],
          password: (userDoc.data()! as Map<String, dynamic>)['password'],
          fullName: fullName,
          dob: Timestamp.fromDate(dob),
          gender: gender,
          phoneNumber: phoneNumber,
          profileImage: profileImageUrl,
          biography: (userDoc.data()! as Map<String, dynamic>)['biography'],
        );

        await firestore.collection('users').doc(uid).set(user.toJson());

        // Get.to(
        //   () => const NavigationContainer(),
        //   transition: Transition.leftToRightWithFade,
        //   duration: const Duration(
        //     seconds: 1,
        //   ),
        // );

        Get.to(
          () => ProfilePage(uid: authController.user.uid),
          transition: Transition.rightToLeftWithFade,
          duration: const Duration(
            seconds: 1,
          ),
        );
      } else {
        Get.snackbar(
          'Error Updating Profile',
          'Please check your fields',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
          colorText: mainWhite,
        );
        Get.back();
      }
    } catch (e) {
      Get.snackbar(
        'Error Something went wrong',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        colorText: mainWhite,
      );
      Get.back();
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

  updateBiography(String biography) async {
    try {
      if (biography.isNotEmpty) {
        String uid = firebaseAuth.currentUser!.uid; // get currentUser id

        DocumentSnapshot userDoc =
            await firestore.collection('users').doc(uid).get();

        user_model.User user = user_model.User(
          uid: uid,
          userId: (userDoc.data()! as Map<String, dynamic>)['userId'],
          userStatus: (userDoc.data()! as Map<String, dynamic>)['userStatus'],
          dateJoined: (userDoc.data()! as Map<String, dynamic>)['dateJoined'],
          username: (userDoc.data()! as Map<String, dynamic>)['username'],
          email: (userDoc.data()! as Map<String, dynamic>)['email'],
          password: (userDoc.data()! as Map<String, dynamic>)['password'],
          fullName: (userDoc.data()! as Map<String, dynamic>)['fullName'],
          dob: (userDoc.data()! as Map<String, dynamic>)['dob'],
          gender: (userDoc.data()! as Map<String, dynamic>)['gender'],
          phoneNumber: (userDoc.data()! as Map<String, dynamic>)['phoneNumber'],
          profileImage:
              (userDoc.data()! as Map<String, dynamic>)['profileImage'],
          biography: biography,
        );

        await firestore.collection('users').doc(uid).set(user.toJson());

        Get.snackbar('Bio Updated Successfully',
            'Your Personal Summary has beenn Updated Successfully',
            snackPosition: SnackPosition.TOP,
            duration: const Duration(seconds: 5),
            colorText: mainWhite,
            backgroundColor: mainBlack);

        Get.to(
          () => ProfilePage(uid: authController.user.uid),
          transition: Transition.rightToLeftWithFade,
          duration: const Duration(
            seconds: 1,
          ),
        );
      } else {
        Get.snackbar('Error Updating Profile', 'Please check your fields',
            snackPosition: SnackPosition.TOP,
            duration: const Duration(seconds: 5),
            colorText: mainWhite,
            backgroundColor: mainBlack);
      }
    } catch (e) {
      Get.snackbar(
        'Error Something went wrong',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        colorText: mainWhite,
      );
    }
  }

  // update profile image
  updateProfileImage(String profileImage) async {
    try {
      if (profileImage.isNotEmpty) {
        String uid = firebaseAuth.currentUser!.uid; // get currentUser id

        DocumentSnapshot userDoc =
            await firestore.collection('users').doc(uid).get();

        user_model.User user = user_model.User(
          uid: uid,
          userId: (userDoc.data()! as Map<String, dynamic>)['userId'],
          userStatus: (userDoc.data()! as Map<String, dynamic>)['userStatus'],
          dateJoined: (userDoc.data()! as Map<String, dynamic>)['dateJoined'],
          username: (userDoc.data()! as Map<String, dynamic>)['username'],
          email: (userDoc.data()! as Map<String, dynamic>)['email'],
          password: (userDoc.data()! as Map<String, dynamic>)['password'],
          fullName: (userDoc.data()! as Map<String, dynamic>)['fullName'],
          dob: (userDoc.data()! as Map<String, dynamic>)['dob'],
          gender: (userDoc.data()! as Map<String, dynamic>)['gender'],
          phoneNumber: (userDoc.data()! as Map<String, dynamic>)['phoneNumber'],
          profileImage: profileImage,
          biography: (userDoc.data()! as Map<String, dynamic>)['biography'],
        );

        await firestore.collection('users').doc(uid).set(user.toJson());

        Get.snackbar('Bio Updated Successfully',
            'Your Personal Summary has beenn Updated Successfully',
            snackPosition: SnackPosition.TOP,
            duration: const Duration(seconds: 5),
            colorText: mainWhite,
            backgroundColor: mainBlack);
      }
    } catch (e) {
      Get.snackbar(
        'Error Something went wrong',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        colorText: mainWhite,
      );
    }
  }
}
