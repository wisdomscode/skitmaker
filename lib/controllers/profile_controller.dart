import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:skitmaker/constants/constance.dart';

class ProfileController extends GetxController {
  final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get user => _user.value;

  final _uid = "".obs;

  updateUserId(String uid) {
    _uid.value = uid;
    getUserData();
  }

  getUserData() async {
    List<String> thumbnails = [];
    var mySkits = await firestore
        .collection('skits')
        .where('uid', isEqualTo: _uid.value)
        .get();
    for (int i = 0; i < mySkits.docs.length; i++) {
      thumbnails.add((mySkits.docs[i].data() as dynamic)['thumbnail']);
    }

    DocumentSnapshot userDoc =
        await firestore.collection('users').doc(_uid.value).get();

    final userData = userDoc.data()! as dynamic;

    String username = userData['username'];
    String fullName = userData['fullName'];
    String profileImage = userData['profileImage'];
    String email = userData['email'];
    String phoneNumber = userData['phoneNumber'];
    String gender = userData['gender'];
    Timestamp dob = userData['dob'];
    int likes = 0;
    int followers = 0;
    int following = 0;
    bool isFollowing = false;

    firestore
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .doc(authController.user.uid)
        .get()
        .then((value) {
      if (value.exists) {
        isFollowing = true;
      } else {
        isFollowing = false;
      }
    });

    // get all user's likes
    for (var item in mySkits.docs) {
      likes += (item.data()['likes'] as List).length;
    }

    // get followers
    var followerDoc = await firestore
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .get();

    // get following
    var followingDoc = await firestore
        .collection('users')
        .doc(_uid.value)
        .collection('following')
        .get();

    followers = followerDoc.docs.length;
    following = followingDoc.docs.length;

    // to check if current user is already following this user or not
    firestore
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .doc(authController.user.uid)
        .get()
        .then((value) {
      if (value.exists) {
        isFollowing = true;
      } else {
        isFollowing = false;
      }
    });

    _user.value = {
      'likes': likes.toString(),
      'followers': followers.toString(),
      'following': following.toString(),
      'isFollowing': isFollowing,
      'profileImage': profileImage,
      'username': username,
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'gender': gender,
      'dob': dob,
      'thumbnails': thumbnails,
    };

    update();
  }

  // follow user
  followUser() async {
    var doc = await firestore
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .doc(authController.user.uid)
        .get();

    if (!doc.exists) {
      await firestore
          .collection('users')
          .doc(_uid.value)
          .collection('followers')
          .doc(authController.user.uid)
          .set({});

      await firestore
          .collection('users')
          .doc(authController.user.uid)
          .collection('following')
          .doc(_uid.value)
          .set({});

      _user.value.update(
        'followers',
        (value) => (int.parse(value) + 1).toString(),
      );
    } else {
      await firestore
          .collection('users')
          .doc(_uid.value)
          .collection('followers')
          .doc(authController.user.uid)
          .delete();

      await firestore
          .collection('users')
          .doc(authController.user.uid)
          .collection('following')
          .doc(_uid.value)
          .delete();

      _user.value.update(
        'followers',
        (value) => (int.parse(value) - 1).toString(),
      );
    }

    _user.value.update('isFollowing', (value) => !value);
    update();
  }
}
