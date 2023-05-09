import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';
import 'package:skitmaker/constants/colors.dart';
import 'package:skitmaker/constants/constance.dart';
import 'package:skitmaker/controllers/comment_controller.dart';
import 'package:skitmaker/controllers/videoskit_controller.dart';
import 'package:skitmaker/models/skit_model.dart';
import 'package:skitmaker/views/widgets/go_back_button.dart';
import 'package:skitmaker/views/widgets/large_text.dart';
import 'package:skitmaker/views/widgets/normal_text.dart';
import 'package:video_player/video_player.dart';
import 'package:timeago/timeago.dart' as tago;

class SingleVideoPage extends StatefulWidget {
  const SingleVideoPage({super.key, required this.data});

  final Skit data;

  @override
  State<SingleVideoPage> createState() => _SingleVideoPageState();
}

class _SingleVideoPageState extends State<SingleVideoPage> {
  VideoSkitController skitController = Get.put(VideoSkitController());
  CommentController commentController = Get.put(CommentController());

  late VideoPlayerController _videoController;
  late Future _initializeVideoPlayer;
  bool _isVideoPlaying = true;

  final TextEditingController _commentController = TextEditingController();

  void clearText() {
    _commentController.clear();
  }

  @override
  void initState() {
    _videoController = VideoPlayerController.network(widget.data.skitUrl!);
    _initializeVideoPlayer = _videoController.initialize();
    _videoController.play();
    _videoController.setLooping(true);
    _videoController.setVolume(1);

    skitController.updateViewCounts(widget.data.id);

    super.initState();
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  void _pausePlayVideo() {
    _isVideoPlaying ? _videoController.pause() : _videoController.play();
    setState(() {
      _isVideoPlaying = !_isVideoPlaying;
    });
  }

  double? _progress;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    commentController.updatePostId(widget.data.id);

    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      backgroundColor: mainBlack,
      body: FutureBuilder(
        future: _initializeVideoPlayer,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return isPortrait
                ? Stack(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              color: mainBlack,
                              width: size.width,
                              height: size.height / 3.2,
                              child: GestureDetector(
                                onTap: () {
                                  _pausePlayVideo();
                                },
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    VideoPlayer(_videoController),
                                    IconButton(
                                      onPressed: () {
                                        _pausePlayVideo();
                                      },
                                      icon: Icon(
                                        Icons.play_arrow,
                                        color: Colors.white.withOpacity(
                                            _isVideoPlaying ? 0 : 0.5),
                                        size: 60,
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        VideoProgressIndicator(
                                          _videoController,
                                          allowScrubbing: true,
                                        ),
                                      ],
                                    ),
                                    const Positioned(
                                      top: 30,
                                      left: 10,
                                      child: GoBackButtonWidget(),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, top: 5),
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: lightBlack,
                                      border: Border.all(
                                          width: 1, color: Colors.black),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    height: 100,
                                    width: size.width * 0.83,
                                    child: Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {},
                                          icon: CircleAvatar(
                                            backgroundImage: NetworkImage(
                                              widget.data.profileImage!,
                                              scale: 0.5,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 8),
                                            LargeTextWidget(
                                              text: "@${widget.data.username}",
                                              textColor: Colors.white,
                                              textSize: 14,
                                            ),
                                            const SizedBox(height: 5),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.65,
                                              child: Text(
                                                widget.data.skitTitle!,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: const TextStyle(
                                                  color: mainWhite,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                NormalTextWidget(
                                                  text:
                                                      "${widget.data.views.length.toString()} views",
                                                  textColor:
                                                      Colors.grey.shade500,
                                                ),
                                                const SizedBox(width: 20),
                                                NormalTextWidget(
                                                  text:
                                                      "(${widget.data.category!})",
                                                  textColor:
                                                      Colors.grey.shade500,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 5),
                                            Row(
                                              children: [
                                                NormalTextWidget(
                                                  text:
                                                      "${widget.data.likes.length.toString()} likes",
                                                  textColor:
                                                      Colors.grey.shade500,
                                                ),
                                                const SizedBox(width: 20),
                                                NormalTextWidget(
                                                  text: tago.format(widget
                                                      .data.dateCreated
                                                      .toDate()),
                                                  textColor:
                                                      Colors.grey.shade500,
                                                ),
                                                // check date
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 11),
                                  SizedBox(
                                    height: 110,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () => skitController
                                              .likeSkit(widget.data.id),
                                          child: Icon(
                                            Icons.favorite,
                                            color: widget.data.likes.contains(
                                                    authController.user.uid)
                                                ? mainRed
                                                : grayWhite,
                                            size: 25,
                                          ),
                                        ),
                                        _videoActionItem(
                                          Icons.share,
                                          Colors.white,
                                          () {
                                            Share.share(widget.data.skitUrl!);
                                          },
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 5.0),
                                          child: InkWell(
                                            onTap: () {
                                              FileDownloader.downloadFile(
                                                url: widget.data.skitUrl!,
                                                onProgress:
                                                    (fileName, progress) {
                                                  setState(() {
                                                    _progress = progress;
                                                  });
                                                },
                                                onDownloadCompleted: (path) {
                                                  // print('PATH: $path');
                                                  setState(
                                                    () {
                                                      _progress = null;
                                                      Get.snackbar(
                                                        'Download Complete',
                                                        'Download Completed successful',
                                                        snackPosition:
                                                            SnackPosition.TOP,
                                                        duration:
                                                            const Duration(
                                                                seconds: 3),
                                                        colorText: mainWhite,
                                                        backgroundColor:
                                                            mainBlack,
                                                      );
                                                    },
                                                  );
                                                },
                                              );
                                            },
                                            child: _progress != null
                                                ? const CircularProgressIndicator()
                                                : const Icon(
                                                    Icons.download,
                                                    size: 25,
                                                    color: mainWhite,
                                                  ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, bottom: 15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  LargeTextWidget(
                                    text: 'Description',
                                    textSize: 18,
                                  ),
                                  const SizedBox(height: 5),
                                  ExpandableText(
                                    widget.data.description!,
                                    expandText: 'See more',
                                    collapseText: '  ...Less',
                                    expandOnTextTap: true,
                                    collapseOnTextTap: true,
                                    maxLines: 2,
                                    linkColor: mainWhite,
                                    style: const TextStyle(color: grayWhite),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, bottom: 5.0),
                              child: LargeTextWidget(
                                text: 'Comments',
                                textSize: 18,
                                textColor: mainWhite,
                              ),
                            ),

                            // comments
                            Expanded(
                              child: Obx(() {
                                return ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount:
                                        commentController.comments.length,
                                    itemBuilder: (context, index) {
                                      final comment =
                                          commentController.comments[index];
                                      return ListTile(
                                        leading: CircleAvatar(
                                          radius: 15.0,
                                          backgroundColor: Colors.black,
                                          backgroundImage: NetworkImage(
                                              comment.profileImage),
                                        ),
                                        title: Wrap(
                                          spacing: 10,
                                          children: [
                                            Text(
                                              '@${comment.username}',
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: mainRed,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Text(
                                              comment.comment,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: mainWhite,
                                              ),
                                            ),
                                          ],
                                        ),
                                        subtitle: Row(
                                          children: [
                                            Text(
                                              tago.format(comment.datePublished
                                                  .toDate()),
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
                                          onTap: () => commentController
                                              .likeComment(comment.id),
                                          child: Icon(
                                            Icons.favorite,
                                            color: comment.likes.contains(
                                                    authController.user.uid)
                                                ? mainRed
                                                : grayWhite,
                                            size: 20,
                                          ),
                                        ),
                                      );
                                    });
                              }),
                            ),
                          ],
                        ),
                      ),

                      // enter comments
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          color: lightBlack,
                          child: ListTile(
                            title: TextFormField(
                              controller: _commentController,
                              style: const TextStyle(
                                  fontSize: 16, color: mainWhite),
                              decoration: const InputDecoration(
                                labelText: 'Type Your Comment Here',
                                labelStyle: TextStyle(
                                  fontSize: 16,
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
                                commentController
                                    .postComment(_commentController.text);
                                clearText();
                                FocusScopeNode currentFocus =
                                    FocusScope.of(context);
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
                        ),
                      ),
                    ],
                  )
                : Container(
                    color: mainBlack,
                    width: size.width,
                    height: size.height,
                    child: GestureDetector(
                      onTap: () {
                        _pausePlayVideo();
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          VideoPlayer(_videoController),
                          IconButton(
                            onPressed: () {
                              _pausePlayVideo();
                            },
                            icon: Icon(
                              Icons.play_arrow,
                              color: Colors.white
                                  .withOpacity(_isVideoPlaying ? 0 : 0.5),
                              size: 60,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              VideoProgressIndicator(
                                _videoController,
                                allowScrubbing: true,
                              ),
                            ],
                          ),
                          const Positioned(
                            top: 30,
                            left: 10,
                            child: GoBackButtonWidget(),
                          )
                        ],
                      ),
                    ),
                  );
          } else {
            return Center(
              child: Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }

  _videoActionItem(IconData iconName, Color iconColor, press()) {
    return InkWell(
      onTap: () {
        press();
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 5.0),
        child: Row(
          children: [
            Icon(
              iconName,
              size: 25,
              color: iconColor,
            ),
          ],
        ),
      ),
    );
  }
}
