import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:skitmaker/constants/colors.dart';
import 'package:skitmaker/constants/constance.dart';
import 'package:skitmaker/models/comment_model.dart';

class CommentController extends GetxController {
  final Rx<List<Comment>> _comments = Rx<List<Comment>>([]);

  List<Comment> get comments => _comments.value;

  String _postId = '';
  updatePostId(String id) {
    _postId = id;
    getComment();
  }

  getComment() async {
    _comments.bindStream(
      firestore
          .collection('skits')
          .doc(_postId)
          .collection('comments')
          .orderBy('datePublished', descending: true)
          .snapshots()
          .map(
        (QuerySnapshot query) {
          List<Comment> retValue = [];
          for (var element in query.docs) {
            retValue.add(Comment.fromSnap(element));
          }
          return retValue;
        },
      ),
    );
  }

  postComment(String commentText) async {
    try {
      if (commentText.isNotEmpty) {
        // get the user who is logged in an commenting
        DocumentSnapshot userDoc = await firestore
            .collection('users')
            .doc(authController.user.uid)
            .get();

        // get all the comments made for this post
        var allDocs = await firestore
            .collection('skits')
            .doc(_postId)
            .collection('comments')
            .get();

        int len = allDocs.docs.length;

        // pass the values of comment model
        Comment comment = Comment(
          username: (userDoc.data()! as dynamic)['username'],
          comment: commentText.trim(),
          datePublished: DateTime.now(),
          likes: [],
          profileImage: (userDoc.data()! as dynamic)['profileImage'],
          uid: authController.user.uid,
          id: 'Comment $len',
        );

        // to save the comment to firestore
        await firestore
            .collection('skits')
            .doc(_postId)
            .collection('comments')
            .doc('Comment $len')
            .set(comment.toJson());

        Get.snackbar('Comment Success', 'Your comment was successful',
            snackPosition: SnackPosition.TOP,
            duration: const Duration(seconds: 3),
            colorText: mainWhite,
            backgroundColor: mainBlack);

        // to update the commentCount
        DocumentSnapshot doc =
            await firestore.collection('skits').doc(_postId).get();
        await firestore.collection('skits').doc(_postId).update({
          'commentCount': (doc.data()! as dynamic)['commentCount'] + 1,
        });
      }
    } catch (e) {
      Get.snackbar('Error Commenting', e.toString(),
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
          colorText: mainWhite,
          backgroundColor: mainBlack);
    }
  }

  // to like comments
  likeComment(String id) async {
    var uid = authController.user.uid;

    DocumentSnapshot doc = await firestore
        .collection('skits')
        .doc(_postId)
        .collection('comments')
        .doc(id)
        .get();

    if ((doc.data()! as dynamic)['likes'].contains(uid)) {
      await firestore
          .collection('skits')
          .doc(_postId)
          .collection('comments')
          .doc(id)
          .update(
        {
          'likes': FieldValue.arrayRemove([uid]),
        },
      );
    } else {
      await firestore
          .collection('skits')
          .doc(_postId)
          .collection('comments')
          .doc(id)
          .update(
        {
          'likes': FieldValue.arrayUnion([uid]),
        },
      );
    }
  }
}
