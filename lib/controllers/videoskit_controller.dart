import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:skitmaker/constants/colors.dart';
import 'package:skitmaker/constants/constance.dart';
import 'package:skitmaker/models/skit_model.dart';

class VideoSkitController extends GetxController {
  final Rx<List<Skit>> _videoSkitList = Rx<List<Skit>>([]);
  List<Skit> get videoSkitList => _videoSkitList.value;

  final Rx<List<Skit>> _trendySkitList = Rx<List<Skit>>([]);
  List<Skit> get trendySkitList => _trendySkitList.value;

  final Rx<List<Skit>> _shortSkitList = Rx<List<Skit>>([]);
  List<Skit> get shortSkitList => _shortSkitList.value;

  // another way
  // final videoSkitList = <Skit>[].obs;
  @override
  void onInit() {
    super.onInit();

    _videoSkitList.bindStream(
      firestore
          .collection('skits')
          .where("skitType", isEqualTo: "video-skit")
          .orderBy('dateCreated', descending: true)
          .snapshots()
          .map((QuerySnapshot query) {
        List<Skit> retVal = [];

        for (var element in query.docs) {
          retVal.add(Skit.fromSnap(element));
        }
        return retVal;
      }),
    );

    _trendySkitList.bindStream(
      firestore
          .collection('skits')
          .where("skitType", isEqualTo: "video-skit")
          .where("commentCount", isGreaterThanOrEqualTo: 5)
          .snapshots()
          .map((QuerySnapshot query) {
        List<Skit> retVal = [];

        for (var element in query.docs) {
          retVal.add(Skit.fromSnap(element));
        }
        return retVal;
      }),
    );

    _shortSkitList.bindStream(
      firestore
          .collection('skits')
          .where("skitType", isEqualTo: "short-skit")
          .orderBy("dateCreated", descending: true)
          .snapshots()
          .map((QuerySnapshot query) {
        List<Skit> retVal = [];

        for (var element in query.docs) {
          retVal.add(Skit.fromSnap(element));
        }
        return retVal;
      }),
    );

    // another way
    // videoSkitList.bindStream(allVideoSkits());
  }

  // get a single skit
  getSingleVideo(String skitId) async {
    DocumentSnapshot getVideoSkit = await firestore
        .collection('skits')
        .doc(skitId)
        .get()
        .then((querySnapshot) {
      print(querySnapshot.data()!['skitType']);
      return querySnapshot;
    });
  }

  // like and unlike skit function
  likeSkit(String id) async {
    DocumentSnapshot doc = await firestore.collection('skits').doc(id).get();
    var uid = authController.user.uid;

    if ((doc.data()! as dynamic)['likes'].contains(uid)) {
      await firestore.collection('skits').doc(id).update({
        'likes': FieldValue.arrayRemove([uid]),
      });
    } else {
      await firestore.collection('skits').doc(id).update({
        'likes': FieldValue.arrayUnion([uid]),
      });
    }
  }

  updateShareCount(String id) async {
    try {
      DocumentSnapshot doc = await firestore.collection('skits').doc(id).get();
      await firestore.collection('skits').doc(id).update({
        'shareCount': (doc.data()! as dynamic)['shareCount'] + 1,
      });
    } catch (e) {
      Get.snackbar('Share Failed!', e.toString(),
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
          colorText: mainWhite,
          backgroundColor: mainBlack);
    }
  }

  updateDownloadCount(String id) async {
    try {
      DocumentSnapshot doc = await firestore.collection('skits').doc(id).get();
      await firestore.collection('skits').doc(id).update({
        'downloadCount': (doc.data()! as dynamic)['downloadCount'] + 1,
      });
    } catch (e) {
      Get.snackbar('Download Failed!', e.toString(),
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
          colorText: mainWhite,
          backgroundColor: mainBlack);
    }
  }

  updateViewCounts(String id) async {
    DocumentSnapshot doc = await firestore.collection('skits').doc(id).get();
    var uid = authController.user.uid;

    // check if user has viewd skit
    if (!(doc.data()! as dynamic)['views'].contains(uid)) {
      await firestore.collection('skits').doc(id).update({
        'views': FieldValue.arrayUnion([uid])
      });
    }
  }

  // another method to get video skits
  // Stream<List<Skit>> allVideoSkits() {
  //   return firestore
  //       .collection('skits')
  //       .where("skitType", isEqualTo: "video-skit")
  //       .orderBy('dateCreated', descending: true)
  //       .snapshots()
  //       .map((snapshot) {
  //     return snapshot.docs.map((doc) => Skit.fromSnap(doc)).toList();
  //   });
  // }
}
