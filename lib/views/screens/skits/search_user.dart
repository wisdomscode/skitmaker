import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:skitmaker/constants/colors.dart';
import 'package:skitmaker/controllers/search_controller.dart';
import 'package:skitmaker/models/user_model.dart';
import 'package:skitmaker/views/screens/profile/profile_page.dart';
import 'package:skitmaker/views/widgets/custom_appbar_widget.dart';
import 'package:skitmaker/views/widgets/large_text.dart';

class SearchUserScreen extends StatelessWidget {
  SearchUserScreen({super.key});

  final SearchController searchController = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Obx(() {
      return Scaffold(
        backgroundColor: mainBlack,
        appBar: CustomAppBarWidget(),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  filled: false,
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                style: const TextStyle(color: mainWhite),
                onFieldSubmitted: (value) => searchController.searchUser(value),
              ),
            ),
            Expanded(
              child: searchController.seachedUsers.isEmpty
                  ? Center(
                      child: LargeTextWidget(
                        text: 'Search for users!',
                        textColor: mainWhite,
                        textSize: 25,
                      ),
                    )
                  : ListView.builder(
                      itemCount: searchController.seachedUsers.length,
                      itemBuilder: (context, index) {
                        User user = searchController.seachedUsers[index];
                        return InkWell(
                          onTap: () {
                            Get.to(
                                () => ProfilePage(
                                      uid: user.uid,
                                    ),
                                transition: Transition.leftToRightWithFade,
                                duration: const Duration(seconds: 1));
                          },
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(user.profileImage!),
                              backgroundColor: mainBlack,
                            ),
                            title: Text(
                              user.username,
                              style: const TextStyle(color: mainWhite),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      );
    });
  }
}
