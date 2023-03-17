import 'package:flutter/material.dart';
import 'package:skitmaker/constants/constance.dart';
import 'package:skitmaker/navigation_container.dart';
import 'package:get/get.dart';
import 'package:skitmaker/views/screens/skits/search_user.dart';
import 'package:skitmaker/views/widgets/custom_popup_menu_button.dart';

class CustomAppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomAppBarWidget> createState() => _CustomAppBarWidgetState();

  @override
  Size get preferredSize => const Size(double.infinity, 60);
}

class _CustomAppBarWidgetState extends State<CustomAppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Get.to(
            () => const NavigationContainer(),
            transition: Transition.rightToLeftWithFade,
            duration: const Duration(
              seconds: 1,
            ),
          ),
          icon: Image.asset(
            'images/skitmaker_icon.png',
          ),
        ),
        leadingWidth: 70,
        elevation: 0,
        title: const Text(
          'Skitmaker',
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.notifications_outlined), onPressed: () {}),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => Get.to(
              () => SearchUserScreen(),
              transition: Transition.leftToRightWithFade,
              duration: const Duration(
                seconds: 1,
              ),
            ),
          ),
          CustomPopupMenuButton(
            uid: authController.user.uid,
          )
        ],
      ),
    );
  }
}
