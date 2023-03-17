import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:skitmaker/constants/colors.dart';
import 'package:skitmaker/constants/constance.dart';
import 'package:skitmaker/controllers/profile_controller.dart';
import 'package:skitmaker/views/screens/admin/all_users.dart';
import 'package:skitmaker/views/screens/profile/interest_categories.dart';
import 'package:skitmaker/views/screens/profile/profile_page.dart';
import 'package:get/get.dart';

class CustomPopupMenuButton extends StatefulWidget {
  const CustomPopupMenuButton({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  State<CustomPopupMenuButton> createState() => _CustomPopupMenuButtonState();
}

class _CustomPopupMenuButtonState extends State<CustomPopupMenuButton> {
  ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    profileController.updateUserId(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    dynamic prof_image;
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          return Column(
            children: [
              PopupMenuButton(
                itemBuilder: (context) {
                  return [
                    PopupMenuItem<int>(
                      value: -1,
                      child: Row(
                        children: [
                          Text(
                            "Hi, ${controller.user['username']} ",
                            style: const TextStyle(
                                color: lightBlack,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem<int>(
                      value: 0,
                      child: Row(
                        children: const [
                          Icon(Icons.person, color: lightBlack),
                          SizedBox(width: 5),
                          Text(
                            "My Profile ",
                            style: const TextStyle(
                                color: lightBlack,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem<int>(
                      value: 1,
                      child: Row(
                        children: const [
                          Icon(Icons.settings, color: lightBlack),
                          SizedBox(width: 5),
                          Text(
                            'Interests',
                            style: TextStyle(
                                color: lightBlack,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem<int>(
                      value: 2,
                      child: Row(
                        children: const [
                          Icon(Icons.people, color: lightBlack),
                          SizedBox(width: 5),
                          Text(
                            'All Users',
                            style: TextStyle(
                                color: lightBlack,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem<int>(
                      value: 3,
                      child: Row(
                        children: const [
                          Icon(Icons.logout, color: lightBlack),
                          SizedBox(width: 5),
                          Text(
                            'Logout',
                            style: TextStyle(
                                color: lightBlack,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ];
                },
                offset: const Offset(0, 100),
                color: Colors.grey,
                elevation: 2,
                onSelected: (value) {
                  if (value == 0) {
                    Get.to(() => ProfilePage(uid: authController.user.uid),
                        transition: Transition.leftToRightWithFade,
                        duration: const Duration(
                          seconds: 1,
                        ));
                  } else if (value == 1) {
                    // navToUserprofile();
                    // choose interests
                    Get.to(() => const InterestCategoryPage(),
                        transition: Transition.leftToRightWithFade,
                        duration: const Duration(
                          seconds: 1,
                        ));
                  } else if (value == 2) {
                    Get.to(() => const AllUsers(),
                        transition: Transition.leftToRightWithFade,
                        duration: const Duration(
                          seconds: 1,
                        ));
                  } else if (value == 3) {
                    authController.logout();
                  }
                },
                splashRadius: 30,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, right: 20),
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: controller.user['profileImage'] ??
                          'images/profiles/profile-2.png',
                      fit: BoxFit.cover,
                      height: 35,
                      width: 35,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          Image.asset('images/profiles/profile-2.png'),
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
