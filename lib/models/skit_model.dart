import 'package:cloud_firestore/cloud_firestore.dart';

class Skit {
  String skitType;
  String uid;
  String username;
  String id;
  List likes;
  int views;
  int commentCount;
  int shareCount;
  String? category;
  String? skitTitle;
  String? description;
  String? tags;
  String? skitUrl;
  String? thumbnail;
  String? profileImage;
  final dateCreated;

  Skit({
    required this.skitType,
    required this.uid,
    required this.username,
    required this.id,
    required this.likes,
    required this.views,
    required this.commentCount,
    required this.shareCount,
    this.category,
    this.skitTitle,
    this.description,
    this.tags,
    this.skitUrl,
    this.thumbnail,
    this.profileImage,
    required this.dateCreated,
  });

  Map<String, dynamic> toJson() => {
        "skitType": skitType,
        "uid": uid,
        "username": username,
        'id': id,
        "likes": likes,
        "views": views,
        "commentCount": commentCount,
        "shareCount": shareCount,
        "category": category,
        "skitTitle": skitTitle,
        "description": description,
        "tags": tags,
        "skitUrl": skitUrl,
        "thumbnail": thumbnail,
        "profileImage": profileImage,
        "dateCreated": dateCreated,
      };

  static Skit fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Skit(
      skitType: snapshot['skitType'],
      uid: snapshot['uid'],
      username: snapshot['username'],
      id: snapshot['id'],
      likes: snapshot['likes'],
      views: snapshot['views'],
      commentCount: snapshot['commentCount'],
      shareCount: snapshot['shareCount'],
      category: snapshot['category'],
      skitTitle: snapshot['skitTitle'],
      description: snapshot['description'],
      tags: snapshot['tags'],
      skitUrl: snapshot['skitUrl'],
      thumbnail: snapshot['thumbnail'],
      profileImage: snapshot['profileImage'],
      dateCreated: snapshot['dateCreated'],
    );
  }
}
