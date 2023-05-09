import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skitmaker/constants/constance.dart';
import 'package:skitmaker/models/skit_model.dart';
import 'package:skitmaker/navigation_container.dart';
import 'package:video_compress/video_compress.dart';

class UploadVideoController extends GetxController {
  // to compress video
  _compressVideo(String videoPath) async {
    final compressedVideo = await VideoCompress.compressVideo(
      videoPath,
      quality: VideoQuality.MediumQuality,
    );
    return compressedVideo!.file;
  }

  // adding video to storage
  Future<String> _uploadVideoToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref().child('videos').child(id);

    UploadTask uploadTask = ref.putFile(await _compressVideo(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  // get video thumbanil
  _getThumbnail(String videoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }

  // add thumbnail to storage
  Future<String> _uploadImageToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref().child('thumbnails').child(id);

    UploadTask uploadTask = ref.putFile(await _getThumbnail(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  // upload video
  uploadVideo(
    String skitTitle,
    String description,
    String videoPath,
    String? category,
    String? tags,
    String skitType,
  ) async {
    try {
      String uid = firebaseAuth.currentUser!.uid; // get currentUser id
      DocumentSnapshot userDoc =
          await firestore.collection('users').doc(uid).get();

      // to get video id
      var allDocs = await firestore.collection('skits').get();
      int len = allDocs.docs.length; //length of all docs in videos collections

      String videoUrl = await _uploadVideoToStorage("Skit $len", videoPath);
      // video thumbnail
      String thumbnail = await _uploadImageToStorage("Skit $len", videoPath);

      Skit skit = Skit(
        skitType: skitType,
        uid: uid,
        username: (userDoc.data()! as Map<String, dynamic>)['username'],
        id: "Skit $len",
        likes: [],
        views: [],
        commentCount: 0,
        shareCount: 0,
        downloadCount: 0,
        category: category,
        skitTitle: skitTitle,
        description: description,
        tags: tags,
        skitUrl: videoUrl,
        thumbnail: thumbnail,
        profileImage: (userDoc.data()! as Map<String, dynamic>)['profileImage'],
        dateCreated: DateTime.now(),
      );

      await firestore.collection('skits').doc('Skit $len').set(skit.toJson());
      Get.to(() => const NavigationContainer());
    } catch (e) {
      Get.snackbar('Error Uploading Skit', e.toString());
    }
  }
}
