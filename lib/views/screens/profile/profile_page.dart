import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:skitmaker/constants/colors.dart';
import 'package:skitmaker/constants/constance.dart';
import 'package:skitmaker/controllers/profile_controller.dart';
import 'package:skitmaker/views/screens/auth/login_page.dart';
import 'package:skitmaker/views/screens/profile/profile_tabs/profiletab_1.dart';
import 'package:skitmaker/views/screens/profile/profile_tabs/profiletab_2.dart';
import 'package:skitmaker/views/screens/profile/profile_tabs/profiletab_3.dart';
import 'package:skitmaker/views/widgets/large_text.dart';
import 'package:skitmaker/views/widgets/normal_text.dart';
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
                  Get.back();
                },
              ),
              actions: [
                PopupMenuButton(
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
                        const PopupMenuItem<int>(
                          value: 0,
                          child: Text("Bookmark Skit"),
                        ),
                        const PopupMenuItem<int>(
                          value: 1,
                          child: Text("Update Profile"),
                        ),
                        const PopupMenuItem<int>(
                          value: 2,
                          child: Text("Logout"),
                        ),
                      ];
                    },
                    onSelected: (value) {
                      if (value == 0) {
                      } else if (value == 1) {
                      } else if (value == 2) {
                        Get.to(
                          () => LoginPage(),
                          transition: Transition.zoom,
                          duration: Duration(seconds: 1),
                        );
                      }
                    }),
              ],
            ),
            backgroundColor: mainWhite,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //profile photo
                    ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: controller.user['profileImage'],
                        fit: BoxFit.cover,
                        height: 120,
                        width: 120,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            Image.asset('images/profiles/profile-2.png'),
                      ),
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
                      padding: const EdgeInsets.only(left: 25.0, right: 10),
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
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Biography',
                                    style: TextStyle(
                                        color: mainBlack,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  NormalTextWidget(
                                    text:
                                        'This is this account bio, In publishing and graphic design',
                                    textColor: darkGrey,
                                    textSize: 16,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // video list
                    GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.user['thumbnails'].length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1,
                          crossAxisSpacing: 5,
                        ),
                        itemBuilder: (context, index) {
                          String thumbnail =
                              controller.user['thumbnails'][index];
                          return CachedNetworkImage(
                            imageUrl: thumbnail,
                            fit: BoxFit.cover,
                          );
                        })
                  ],
                ),
              ),
            ),
          );
        });
  }
}
