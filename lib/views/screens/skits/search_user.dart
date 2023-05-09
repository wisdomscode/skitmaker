import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:skitmaker/constants/colors.dart';
import 'package:skitmaker/constants/constance.dart';
import 'package:skitmaker/views/screens/profile/profile_page.dart';
import 'package:skitmaker/views/widgets/go_back_button.dart';

class SearchUserScreen extends StatefulWidget {
  const SearchUserScreen({super.key});

  @override
  State<SearchUserScreen> createState() => _SearchUserScreenState();
}

class _SearchUserScreenState extends State<SearchUserScreen> {
  String name = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBlack,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: mainBlack,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GoBackButtonWidget(),
          )
        ],
        title: TextFormField(
          style: const TextStyle(color: mainWhite),
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search, color: mainWhite),
            hintText: 'Search...',
            hintStyle: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          onChanged: (value) {
            setState(() {
              name = value;
            });
          },
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.collection('users').snapshots(),
        builder: (context, snapshots) {
          // var item = snapshots.data;
          // if (item != null) {
          return (snapshots.connectionState == ConnectionState.waiting)
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: snapshots.data!.docs.length,
                  itemBuilder: (context, index) {
                    var user = snapshots.data!.docs[index].data()
                        as Map<String, dynamic>;

                    if (name.isEmpty) {
                      return InkWell(
                        onTap: () {
                          Get.to(
                              () => ProfilePage(
                                    uid: user['uid'],
                                  ),
                              transition: Transition.leftToRightWithFade,
                              duration: const Duration(seconds: 1));
                        },
                        child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(user['profileImage']),
                              backgroundColor: mainBlack,
                            ),
                            title: Text(
                              user['username'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: mainWhite,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              user['email'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: mainWhite, fontSize: 13),
                            )),
                      );
                    }

                    if (user['username']
                            .toString()
                            .startsWith(name.toLowerCase()) ||
                        user['username']
                            .toString()
                            .startsWith(name.toUpperCase())) {
                      return InkWell(
                        onTap: () {
                          Get.to(
                              () => ProfilePage(
                                    uid: user['uid'],
                                  ),
                              transition: Transition.leftToRightWithFade,
                              duration: const Duration(seconds: 1));
                        },
                        child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(user['profileImage']),
                              backgroundColor: mainBlack,
                            ),
                            title: Text(
                              user['username'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: mainWhite,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              user['email'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: mainWhite, fontSize: 13),
                            )),
                      );
                    }

                    return Container();
                  },
                );
          // }
          // return Container();
        },
      ),
    );
  }
}
