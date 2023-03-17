import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skitmaker/constants/colors.dart';
import 'package:skitmaker/constants/constance.dart';
import 'package:skitmaker/controllers/comment_controller.dart';
import 'package:skitmaker/views/widgets/go_back_button.dart';
import 'package:skitmaker/views/widgets/large_text.dart';
import 'package:timeago/timeago.dart' as tago;

class CommentScreen extends StatelessWidget {
  CommentScreen({super.key, required this.id});
  final String id;

  final TextEditingController _commentController = TextEditingController();
  CommentController commentController = Get.put(CommentController());

  void clearText() {
    _commentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    commentController.updatePostId(id);
    return Scaffold(
      backgroundColor: lightBlack,
      appBar: AppBar(
        backgroundColor: lightBlack,
        elevation: 0,
        leading: const Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: GoBackButtonWidget(),
        ),
        leadingWidth: 70,
        title: LargeTextWidget(text: 'Comments', textSize: 20),
        centerTitle: true,
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                return ListView.builder(
                    itemCount: commentController.comments.length,
                    itemBuilder: (context, index) {
                      final comment = commentController.comments[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.black,
                          backgroundImage: NetworkImage(comment.profileImage),
                        ),
                        title: Wrap(
                          spacing: 20,
                          children: [
                            Text(
                              '@${comment.username}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: mainRed,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              comment.comment,
                              style: const TextStyle(
                                fontSize: 16,
                                color: mainWhite,
                                // fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        subtitle: Row(
                          children: [
                            Text(
                              tago.format(comment.datePublished.toDate()),
                              style: const TextStyle(
                                fontSize: 10,
                                color: grayWhite,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              '${comment.likes.length} likes',
                              style: const TextStyle(
                                fontSize: 10,
                                color: grayWhite,
                              ),
                            ),
                          ],
                        ),
                        trailing: InkWell(
                          onTap: () =>
                              commentController.likeComment(comment.id),
                          child: Icon(
                            Icons.favorite,
                            color:
                                comment.likes.contains(authController.user.uid)
                                    ? mainRed
                                    : grayWhite,
                            size: 25,
                          ),
                        ),
                      );
                    });
              }),
            ),
            const Divider(),
            ListTile(
              title: TextFormField(
                controller: _commentController,
                style: const TextStyle(fontSize: 16, color: mainWhite),
                decoration: const InputDecoration(
                  labelText: 'Comment',
                  labelStyle: TextStyle(
                    fontSize: 20,
                    color: mainWhite,
                    fontWeight: FontWeight.w700,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: mainRed),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: mainRed),
                  ),
                ),
              ),
              trailing: ElevatedButton(
                onPressed: () {
                  commentController.postComment(_commentController.text);
                  clearText();
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                },
                child: const Icon(
                  Icons.send,
                  color: mainWhite,
                  // size: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
