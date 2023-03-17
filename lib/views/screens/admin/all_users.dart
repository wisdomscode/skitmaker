import 'package:flutter/material.dart';

import 'package:skitmaker/models/user_model.dart' as user_model;
import 'package:skitmaker/constants/constance.dart';
import 'package:transparent_image/transparent_image.dart';

class AllUsers extends StatelessWidget {
  const AllUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Users'),
      ),
      body: StreamBuilder<List<user_model.User>>(
          stream: readUsers(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong! ${snapshot.error}');
            } else if (snapshot.hasData) {
              final users = snapshot.data!;

              return ListView(
                children: users.map(buildUser).toList(),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  // get all users
  Stream<List<user_model.User>> readUsers() =>
      firestore.collection('users').snapshots().map((snapshot) =>
          snapshot.docs.map((doc) => user_model.User.fromSnap(doc)).toList());

  Widget buildUser(user_model.User user) => ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: (user.profileImage != null)
              ? FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: '${user.profileImage}',
                )
              : CircleAvatar(child: Text(user.username[0])),
        ),
        title: Text(user.username),
        subtitle: Text(user.email),
      );
}
