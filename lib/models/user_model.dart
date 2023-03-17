import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String uid;
  String username;
  String email;
  String password;
  String? fullName;
  DateTime? dob;
  String? phoneNumber;
  String? gender;
  String? profileImage;

  User(
      {required this.uid,
      required this.username,
      required this.email,
      required this.password,
      this.fullName,
      this.dob,
      this.phoneNumber,
      this.gender,
      this.profileImage});

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'username': username,
        'email': email,
        'password': password,
        'fullName': fullName,
        'dob': dob,
        'phoneNumber': phoneNumber,
        'gender': gender,
        'profileImage': profileImage,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      uid: snapshot['uid'],
      username: snapshot['username'],
      email: snapshot['email'],
      password: snapshot['password'],
      fullName: snapshot['fullName'],
      dob: (snapshot['dob'] as Timestamp).toDate(),
      phoneNumber: snapshot['phoneNumber'],
      gender: snapshot['gender'],
      profileImage: snapshot['profileImage'],
    );
  }

  // static User fromJson(Map<String, dynamic> snapshot) {
  //   return User(
  //     uid: snapshot['uid'],
  //     username: snapshot['username'],
  //     email: snapshot['email'],
  //     password: snapshot['password'],
  //     fullName: snapshot['fullName'],
  //     dob: (snapshot['dob'] as Timestamp).toDate(),
  //     phoneNumber: snapshot['phoneNumber'],
  //     gender: snapshot['gender'],
  //     profileImage: snapshot['profileImage'],
  //     );
  // }

}
