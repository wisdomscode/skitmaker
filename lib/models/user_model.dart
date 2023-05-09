import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String uid;
  int userId;
  String userStatus;
  Timestamp dateJoined;
  String username;
  String email;
  String password;
  String? fullName;
  Timestamp dob;
  String? phoneNumber;
  String? gender;
  String? profileImage;
  String? biography;

  User({
    required this.uid,
    required this.userId,
    required this.userStatus,
    required this.dateJoined,
    required this.username,
    required this.email,
    required this.password,
    this.fullName,
    required this.dob,
    this.phoneNumber,
    this.gender,
    this.profileImage,
    this.biography,
  });

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'userId': userId,
        'userStatus': userStatus,
        'dateJoined': dateJoined,
        'username': username,
        'email': email,
        'password': password,
        'fullName': fullName,
        'dob': dob,
        'phoneNumber': phoneNumber,
        'gender': gender,
        'profileImage': profileImage,
        'biography': biography,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      uid: snapshot['uid'],
      userId: snapshot['userId'],
      userStatus: snapshot['userStatus'],
      dateJoined: snapshot['dateJoined'],
      username: snapshot['username'],
      email: snapshot['email'],
      password: snapshot['password'],
      fullName: snapshot['fullName'],
      dob: snapshot['dob'],
      phoneNumber: snapshot['phoneNumber'],
      gender: snapshot['gender'],
      profileImage: snapshot['profileImage'],
      biography: snapshot['biography'],
    );
  }
}
