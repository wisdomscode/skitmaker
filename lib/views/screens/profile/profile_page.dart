import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:skitmaker/constants/colors.dart';
import 'package:skitmaker/constants/constance.dart';
import 'package:skitmaker/controllers/profile_controller.dart';
import 'package:skitmaker/navigation_container.dart';
import 'package:skitmaker/views/screens/auth/login_page.dart';
import 'package:skitmaker/views/screens/profile/update_biography.dart';
import 'package:skitmaker/views/screens/profile/update_biodata.dart';
import 'package:skitmaker/views/screens/profile/update_profile.dart';
import 'package:skitmaker/views/widgets/dialog_box_widget.dart';

import 'package:skitmaker/views/widgets/large_text.dart';
import 'package:skitmaker/views/widgets/normal_text.dart';
import 'package:skitmaker/views/widgets/or_divider_widget.dart';
import 'package:skitmaker/views/widgets/primary_button_widget.dart';
import 'package:get/get.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.uid});

  final String uid;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileController profileController = Get.put(ProfileController());

  File? imageFile;
  String profileImageUrl = '';

  // 1. Pick image:
  // install image_picker
  // import the corresponding library
  ImagePicker imagePicker = ImagePicker();

  pickImage(ImageSource source) async {
    final XFile? image = await imagePicker.pickImage(source: source);
    print('${image?.path}');

    // code to display selected image on UI and close select button
    if (image != null) {
      imageFile = File(image.path);
      setState(() {});
      Get.back();
    }

    if (image == null) return;

    // Create a referecnce to storage root
    Reference referenceRoot = FirebaseStorage.instance.ref();

    // Create referenceFolder
    Reference referenceDirImage = referenceRoot.child('profileImages');

    String userUid = firebaseAuth.currentUser!.uid; // get currentUser id

    Reference referenceImageToUpload = referenceDirImage.child(userUid);

    try {
      // Store the file
      await referenceImageToUpload.putFile(File(image.path));

      // Success: get the downlaod URL
      profileImageUrl = await referenceImageToUpload.getDownloadURL();

      authController.updateProfileImage(profileImageUrl);
    } catch (e) {
      // Some error occured
    }
  }

  @override
  void initState() {
    super.initState();
    profileController.updateUserId(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          if (controller.user.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Welcome',
                style: TextStyle(color: mainBlack),
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.chevron_left),
                color: mainBlack,
                onPressed: () {
                  // Get.back();
                  Get.to(
                    () => const NavigationContainer(),
                    transition: Transition.rightToLeftWithFade,
                    duration: const Duration(seconds: 2),
                  );
                },
              ),
              actions: [
                widget.uid == authController.user.uid
                    ? PopupMenuButton(
                        // add icon, by default "3 dot" icon
                        child: const Padding(
                          padding: EdgeInsets.only(right: 15.0),
                          child: Icon(
                            Icons.more_vert,
                            color: mainBlack,
                          ),
                        ),
                        itemBuilder: (context) {
                          return [
                            PopupMenuItem<int>(
                              height: 16,
                              padding: const EdgeInsets.only(
                                  top: 10, left: 15, bottom: 10),
                              value: 0,
                              child: Row(
                                children: const [
                                  Icon(Icons.monetization_on_outlined,
                                      color: mainRed, size: 16),
                                  SizedBox(width: 5),
                                  Text("Monetize",
                                      style: TextStyle(fontSize: 14)),
                                ],
                              ),
                            ),
                            PopupMenuItem<int>(
                              height: 16,
                              padding: const EdgeInsets.only(
                                  top: 10, left: 15, bottom: 10),
                              value: 1,
                              child: Row(
                                children: const [
                                  Icon(Icons.logout, color: mainRed, size: 16),
                                  SizedBox(width: 5),
                                  Text("Logout",
                                      style: TextStyle(fontSize: 14)),
                                ],
                              ),
                            ),
                          ];
                        },
                        onSelected: (value) {
                          if (value == 0) {
                            // Monetize channel
                          } else if (value == 1) {
                            Get.to(
                              () => LoginPage(),
                              transition: Transition.zoom,
                              duration: Duration(seconds: 1),
                            );
                          }
                        },
                      )
                    : Container(),
              ],
            ),
            backgroundColor: mainWhite,
            body: Obx(() {
              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      //profile photo
                      Stack(
                        children: [
                          controller.user['profileImage'] != ''
                              ? ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl: controller.user['profileImage'],
                                    fit: BoxFit.cover,
                                    height: 120,
                                    width: 120,
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                            'images/profiles/profile-2.png'),
                                  ),
                                )
                              : Container(
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    image: imageFile == null
                                        ? const DecorationImage(
                                            image: AssetImage(
                                                "images/profiles/profile-2.png"),
                                            fit: BoxFit.fill)
                                        : DecorationImage(
                                            image: FileImage(imageFile!),
                                            fit: BoxFit.fill),
                                    color: mainBlack,
                                    shape: BoxShape.circle,
                                    border:
                                        Border.all(width: 5, color: lightBlack),
                                  ),
                                ),
                          Positioned(
                            bottom: -10,
                            right: -5,
                            child: widget.uid == authController.user.uid
                                ? DialogBoxWidget(
                                    title: 'Update Photo',
                                    content: 'Choose Image Source',
                                    openDialogMessage:
                                        const Icon(Icons.add_a_photo),
                                    firstActionWidget: ElevatedButton.icon(
                                      icon: const Icon(Icons.image_outlined),
                                      label: const Text('From Gallery'),
                                      onPressed: () =>
                                          pickImage(ImageSource.gallery),
                                    ),
                                    secondActionWidget: ElevatedButton.icon(
                                      icon:
                                          const Icon(Icons.camera_alt_outlined),
                                      label: const Text('From Camera'),
                                      onPressed: () =>
                                          pickImage(ImageSource.camera),
                                    ),
                                  )
                                : Container(),
                          )
                        ],
                      ),

                      // username
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 15),
                        child: Text(
                          "@${controller.user['username']}",
                          style: const TextStyle(
                            color: mainBlack,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      // number of following, followers, likes
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: Column(
                                children: [
                                  LargeTextWidget(
                                    text: controller.user['following'],
                                    textColor: mainBlack,
                                    textSize: 20,
                                  ),
                                  NormalTextWidget(
                                    text: 'Following',
                                    textColor: darkGrey,
                                    textSize: 16,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  LargeTextWidget(
                                    text: controller.user['followers'],
                                    textColor: mainBlack,
                                    textSize: 20,
                                  ),
                                  NormalTextWidget(
                                    text: 'Followers',
                                    textColor: darkGrey,
                                    textSize: 16,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                children: [
                                  LargeTextWidget(
                                    text: controller.user['likes'],
                                    textColor: mainBlack,
                                    textSize: 20,
                                  ),
                                  NormalTextWidget(
                                    text: 'Likes',
                                    textColor: darkGrey,
                                    textSize: 16,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),

                      const SizedBox(height: 15),
                      // button - follow, unfollow, sign out
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: MainButtomWidget(
                          btnText: widget.uid == authController.user.uid
                              ? 'Sign Out'
                              : controller.user['isFollowing']
                                  ? 'Unfollow'
                                  : 'Follow',
                          press: () {
                            if (widget.uid == authController.user.uid) {
                              authController.logout();
                            } else {
                              controller.followUser();
                            }
                          },
                          active: true,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Row(
                            children: [
                              const Text('Bio Data',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold)),
                              const Spacer(),
                              Material(
                                elevation: 2,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40))),
                                color: mainRed,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(40),
                                  onTap: () {
                                    Get.to(() => const UpdateBioData(),
                                        arguments: [
                                          {'uid': authController.user.uid},
                                          {
                                            "username":
                                                controller.user['username']
                                          },
                                          {"email": controller.user['email']},
                                          {
                                            "fullName":
                                                controller.user['fullName']
                                          },
                                          {"dob": controller.user['dob']},
                                          {
                                            "phoneNumber":
                                                controller.user['phoneNumber']
                                          },
                                          {"gender": controller.user['gender']},
                                          {
                                            "profileImage":
                                                controller.user['profileImage']
                                          },
                                        ],
                                        transition:
                                            Transition.leftToRightWithFade,
                                        duration: const Duration(seconds: 1));
                                  },
                                  child: widget.uid == authController.user.uid
                                      ? const Padding(
                                          padding: EdgeInsets.all(5.0),
                                          child: Icon(Icons.edit,
                                              color: mainWhite, size: 20),
                                        )
                                      : Container(),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 70,
                                    child: Text(
                                      'Name:',
                                      style: TextStyle(
                                        color: mainBlack,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    controller.user['fullName'],
                                    style: const TextStyle(
                                      color: mainBlack,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 70,
                                    child: Text(
                                      'Email:',
                                      style: TextStyle(
                                        color: mainBlack,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    controller.user['email'],
                                    style: const TextStyle(
                                      color: mainBlack,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 70,
                                    child: Text(
                                      'Phone:',
                                      style: TextStyle(
                                        color: mainBlack,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    controller.user['phoneNumber'],
                                    style: const TextStyle(
                                      color: mainBlack,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 70,
                                    child: Text(
                                      'Gender:',
                                      style: TextStyle(
                                        color: mainBlack,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    controller.user['gender'],
                                    style: const TextStyle(
                                      color: mainBlack,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 70,
                                    child: Text(
                                      'DOB:',
                                      style: TextStyle(
                                        color: mainBlack,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    DateFormat("dd/MM/yyyy").format(
                                      DateTime.parse(controller.user['dob']
                                          .toDate()
                                          .toString()),
                                    ),
                                    style: const TextStyle(
                                      color: mainBlack,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              // bio
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              decoration:
                                  const BoxDecoration(color: lightBlack),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 8.0),
                                child: Row(
                                  children: [
                                    const Text(
                                      'Personal Summary',
                                      style: TextStyle(
                                          color: Colors.yellow,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Spacer(),
                                    Material(
                                      elevation: 10,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(40))),
                                      color: mainRed,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(40),
                                        onTap: () {
                                          showModalBottomSheet(
                                            isScrollControlled: true,
                                            backgroundColor: Colors.transparent,
                                            barrierColor: Colors.black54,
                                            context: context,
                                            builder: (BuildContext context) {
                                              return BiographyUpdate(
                                                biography: controller
                                                    .user['biography'],
                                              );
                                            },
                                          );
                                        },
                                        child: widget.uid ==
                                                authController.user.uid
                                            ? const Padding(
                                                padding: EdgeInsets.all(5.0),
                                                child: Icon(Icons.edit_note,
                                                    color: mainWhite, size: 25),
                                              )
                                            : Container(),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 5.0),
                              child: NormalTextWidget(
                                text: controller.user['biography'],
                                textColor: darkGrey,
                                textSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),

                      // video list
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              decoration:
                                  const BoxDecoration(color: lightBlack),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 15.0),
                                child: Text(
                                  'Skits created by this user',
                                  style: TextStyle(
                                      color: Colors.yellow,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      (controller.user['thumbnails'].length > 0)
                          ? Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount:
                                      controller.user['thumbnails'].length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 1,
                                    crossAxisSpacing: 5,
                                  ),
                                  itemBuilder: (context, index) {
                                    String thumbnail =
                                        controller.user['thumbnails'][index];
                                    String skitId =
                                        controller.user['skitIds'][index];
                                    String skitType =
                                        controller.user['skitTypes'][index];
                                    return GestureDetector(
                                      onTap: () {
                                        // print('Press');
                                        // print(thumbnail);
                                        // print(skitId);
                                        // print(skitType);

                                        // skitController
                                        //     .updateViewCounts(data.id);
                                        getSingleVideo(skitId);
                                        // Get.to(
                                        //   () => SingleVideoPage(data: data),
                                        // );
                                      },
                                      child: CachedNetworkImage(
                                        imageUrl: thumbnail,
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  }),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: LargeTextWidget(
                                text: 'User has NO Skit yet',
                                textColor: mainRed,
                                textSize: 20,
                              ),
                            )
                    ],
                  ),
                ),
              );
            }),
          );
        });
  }
}

getSingleVideo(String skitId) async {
  DocumentSnapshot getVideoSkit = await firestore
      .collection('skits')
      .doc(skitId)
      .get()
      .then((querySnapshot) {
    print(querySnapshot.data()!['skitType']);
    print(querySnapshot);
    return querySnapshot;
  });

  // if
}
