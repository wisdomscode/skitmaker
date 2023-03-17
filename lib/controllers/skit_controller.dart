import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:skitmaker/constants/constance.dart';
import 'package:skitmaker/models/skit_model.dart';

class SkitController extends GetxController {
  // get all skits method 1
  final Rx<List<Skit>> _videoSkitList = Rx<List<Skit>>([]);
  List<Skit> get videoSkitList => _videoSkitList.value;

  final Rx<List<Skit>> _shortSkitList = Rx<List<Skit>>([]);
  List<Skit> get shortSkitList => _shortSkitList.value;

  final Rx<List<Skit>> _trendySkitList = Rx<List<Skit>>([]);
  List<Skit> get trendySkitList => _trendySkitList.value;

  // final videoSkitList = <Skit>[].obs;
  // final shortSkitList = <Skit>[].obs;
  // final trendySkitList = <Skit>[].obs;

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

    // videoSkitList.bindStream(allVideoSkits());

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

    // shortSkitList.bindStream(allShortSkits());

    _trendySkitList.bindStream(
      firestore
          .collection('skits')
          .where("skitType", isEqualTo: "video-skit")
          .where("commentCount", isGreaterThanOrEqualTo: 5)
          // .orderBy('dateCreated', descending: true)
          .snapshots()
          .map((QuerySnapshot query) {
        List<Skit> retVal = [];

        for (var element in query.docs) {
          retVal.add(Skit.fromSnap(element));
        }
        return retVal;
      }),
    );
    // trendySkitList.bindStream(trendingVideoSkits());
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

  // A class that for skits queries
  final FirebaseFirestore _firebasefirestore = FirebaseFirestore.instance;

  // get video skits
  Stream<List<Skit>> allVideoSkits() {
    return _firebasefirestore
        .collection('skits')
        .where("skitType", isEqualTo: "video-skit")
        .orderBy('dateCreated', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Skit.fromSnap(doc)).toList();
    });
  }

  // get shorts skits
  Stream<List<Skit>> allShortSkits() {
    return _firebasefirestore
        .collection("skits")
        .where("skitType", isEqualTo: "short-skit")
        .orderBy("dateCreated", descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Skit.fromSnap(doc)).toList();
    });
  }

  // get trendy skits
  Stream<List<Skit>> trendingVideoSkits() {
    return _firebasefirestore
        .collection("skits")
        .where("skitType", isEqualTo: "video-skit")
        .where("commentCount", isGreaterThanOrEqualTo: 5)
        // .orderBy('dateCreated', descending: true)
        .snapshots()
        .map(
      (snapshot) {
        return snapshot.docs.map((doc) => Skit.fromSnap(doc)).toList();
      },
    );
  }
}




// Sample of WHERE clause in firebase

// stream: FirebaseFirestore.instance
//   .collection(Strings.factsText)
//   .orderBy('timestamp', descending: true)
//   .where(
//     Strings.category,
//     whereIn: [Strings.climateChange])

//     .snapshots(),