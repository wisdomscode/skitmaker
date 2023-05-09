import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skitmaker/constants/constance.dart';
import 'package:skitmaker/navigation_container.dart';
import 'package:http/http.dart' as http;

class SignInProvider extends ChangeNotifier {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;

  // hasError, errorCode, provider, uid, email, name, imageUrl
  bool _hasError = false;
  bool get hasError => _hasError;

  String? _errorCode;
  String? get errorCode => _errorCode;

  String? _uid;
  String? get uid => _uid;

  String? _fullName;
  String? get fullName => _fullName;

  String? _email;
  String? get email => _email;

  String? _password;
  String? get password => _password;

  String? _profileImage;
  String? get profileImage => _profileImage;

  String? _username;
  String? get username => _username;

  DateTime? _dob;
  DateTime? get dob => _dob;

  String? _gender;
  String? get gender => _gender;

  String? _phoneNumber;
  String? get phoneNumber => _phoneNumber;

  String? _biography;
  String? get biography => _biography;

  int? _userId;
  int? get userId => _userId;

  String? _userStatus;
  String? get userStatus => _userStatus;

  Timestamp? _dateJoined;
  Timestamp? get dateJoined => _dateJoined;

  DateTime date = DateTime.now();

  // final now = DateTime.now();
  // final today = DateTime(now.year, now.month, now.day);
  final defaultDate = DateTime.parse("2000-01-01 00:00:00Z");

  // Sign in with Google
  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser != null) {
      try {
        // Obtain the auth details from the request
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        // Create a new credential
        AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        // Once signed in, return the UserCredential
        final User userDetails =
            (await FirebaseAuth.instance.signInWithCredential(credential))
                .user!;

        // get username from email
        String? usernameFromEmail =
            userDetails.email?.substring(0, userDetails.email?.indexOf("@"));

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

        // save user details
        _uid = userDetails.uid;
        _fullName = userDetails.displayName;
        _email = userDetails.email;
        _profileImage = userDetails.photoURL;
        _password = '';
        _phoneNumber = '';
        _gender = '';
        _username = usernameFromEmail;
        _dob = defaultDate;
        _userId = lastuserId + 1;
        _userStatus = 'active';
        _dateJoined = Timestamp.fromDate(date);
        _biography = '';

        _isSignedIn = true;

        notifyListeners();
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case "account-exists-with-different-credential":
            _errorCode =
                "You already have an account with us. Use correct provider";
            _hasError = true;
            notifyListeners();

            break;
          case "user-disabled":
            _errorCode = "Your account is disabled. Contact the Admin.";
            _hasError = true;
            notifyListeners();
            break;
          case "user-not-found":
            _errorCode =
                "You DO NOT have an account with us. Create an account first.";
            _hasError = true;
            notifyListeners();
            break;
          case "null":
            _errorCode = "Some unexpected errors while trying to sign in.";
            _hasError = true;
            notifyListeners();
            break;
          default:
            _errorCode = "Default error -- " + e.toString();
            _hasError = true;
            notifyListeners();
        }
      }
    } else {
      _hasError = true;
      notifyListeners();
    }
  }

  // User Entry from the CloudFirestore when the user exits
  Future getUserDataFromCloudFirestore(uid) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .get()
        .then((DocumentSnapshot snapshot) {
      _uid = snapshot["uid"];
      _fullName = snapshot["fullName"];
      _email = snapshot["email"];
      _profileImage = snapshot["profileImage"];
      _phoneNumber = snapshot["phoneNumber"];
      _gender = snapshot["gender"];
      _dob = snapshot["dob"];
      _username = snapshot["username"];
    });
  }

  // save user data to CloudFirestore when the user does not exist
  Future saveUserDataToCloudFirestore() async {
    final DocumentReference docRef =
        FirebaseFirestore.instance.collection("users").doc(uid);
    await docRef.set({
      "uid": _uid,
      "fullName": _fullName,
      "email": _email,
      "profileImage": _profileImage,
      "phoneNumber": _phoneNumber,
      "gender": _gender,
      "dob": _dob,
      "username": _username,
    });
  }

  // check if User exists in the firebase database or not
  Future<bool> checkUserExists() async {
    DocumentSnapshot snapshot =
        await firestore.collection('users').doc(uid).get();
    if (snapshot.exists) {
      // print("User Exists in the firebase database");
      return true;
    } else {
      // print("User does not exist in the firebase database");
      return false;
    }
  }
}
