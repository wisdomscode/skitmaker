import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:expandable_text/expandable_text.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:share/share.dart';
import 'package:skitmaker/constants/colors.dart';
import 'package:skitmaker/constants/constance.dart';
import 'package:skitmaker/controllers/skit_controller.dart';
import 'package:skitmaker/views/screens/profile/profile_page.dart';
import 'package:skitmaker/views/screens/skits/components/comment_screen.dart';
import 'package:skitmaker/views/screens/skits/components/widgets/video_player_item.dart';

import 'package:timeago/timeago.dart' as tago;

class QuickyPage extends StatefulWidget {
  QuickyPage({super.key});

  final SkitController skitController = Get.put(SkitController());

  @override
  State<QuickyPage> createState() => _QuickyPageState();
}

class _QuickyPageState extends State<QuickyPage>
    with SingleTickerProviderStateMixin {
  _QuickyPageState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
  bool _isFollowingSelected = true;

  late AnimationController _animationController;
  bool _isPlaying = true;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    _animationController.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  double? _progress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _isFollowingSelected = true;
                  print('Following pressed');
                });
              },
              child: Text(
                'Following',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: _isFollowingSelected ? 18 : 15,
                      color: _isFollowingSelected ? Colors.white : Colors.grey,
                      fontWeight: _isFollowingSelected ? FontWeight.w600 : null,
                    ),
              ),
            ),
            Text(
              '    |    ',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _isFollowingSelected = false;
                  print('For you pressed');
                });
              },
              child: Text(
                'For You',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: !_isFollowingSelected ? 18 : 15,
                      color: !_isFollowingSelected ? Colors.white : Colors.grey,
                      fontWeight:
                          !_isFollowingSelected ? FontWeight.w600 : null,
                    ),
              ),
            ),
          ],
        ),
      ),
      body: Obx(() {
        return PageView.builder(
          itemCount: widget.skitController.shortSkitList.length,
          controller: PageController(initialPage: 0, viewportFraction: 1),
          onPageChanged: (int page) => {
            setState(() {}),
          },
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            final data = widget.skitController.shortSkitList[index];
            return Center(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  VideoPlayerItem(
                    skitUrl: data.skitUrl!,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding: const EdgeInsets.only(left: 20, bottom: 20),
                          decoration:
                              const BoxDecoration(color: Colors.transparent),
                          height: MediaQuery.of(context).size.height / 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("@${data.username}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w900,
                                      color: mainWhite)),
                              const SizedBox(height: 5),
                              ExpandableText(
                                data.description!,
                                expandText: 'See more',
                                collapseText: '  ...Less',
                                expandOnTextTap: true,
                                collapseOnTextTap: true,
                                maxLines: 2,
                                linkColor: mainWhite,
                                style: const TextStyle(color: grayWhite),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.music_note,
                                    size: 18.0,
                                    color: mainWhite,
                                  ),
                                  const SizedBox(width: 5),
                                  SizedBox(
                                    height: 20,
                                    width:
                                        MediaQuery.of(context).size.width / 1.7,
                                    child: Marquee(
                                      text: " ---   ${data.skitTitle}",
                                      velocity: 10,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: mainWhite),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 5),
                              Text(
                                tago.format(data.dateCreated.toDate()),
                                style: const TextStyle(color: grayWhite),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                            height: MediaQuery.of(context).size.height / 1.7,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                _profileImageButton(
                                  data.profileImage!,
                                  () {
                                    Get.to(
                                      () => ProfilePage(uid: data.uid),
                                      transition:
                                          Transition.leftToRightWithFade,
                                      duration: const Duration(
                                        seconds: 1,
                                      ),
                                    );
                                  },
                                  () {
                                    Get.to(
                                      () => CommentScreen(id: data.id),
                                      transition: Transition.downToUp,
                                      duration: const Duration(
                                        seconds: 2,
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(height: 5),
                                _sideBarItem(
                                  Icons.thumb_up,
                                  data.likes.contains(authController.user.uid)
                                      ? mainRed
                                      : Colors.white,
                                  () {
                                    widget.skitController.likeSkit(data.id);
                                  },
                                  data.likes.length.toString(),
                                  const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                _sideBarItem(
                                  Icons.chat_rounded,
                                  Colors.white,
                                  () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => CommentScreen(
                                          id: data.id,
                                        ),
                                      ),
                                    );
                                  },
                                  data.commentCount.toString(),
                                  const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 15.0),
                                  child: InkWell(
                                    onTap: () {
                                      Share.share(data.skitUrl!);
                                    },
                                    child: const Icon(
                                      Icons.share,
                                      size: 40,
                                      color: mainWhite,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 15.0),
                                  child: InkWell(
                                    onTap: () {
                                      FileDownloader.downloadFile(
                                        url: data.skitUrl!,
                                        onProgress: (fileName, progress) {
                                          setState(() {
                                            _progress = progress;
                                          });
                                        },
                                        onDownloadCompleted: (path) {
                                          print('PATH: $path');
                                          setState(() {
                                            _progress = null;
                                            Get.snackbar('Download Complete',
                                                'Download Completed successful',
                                                snackPosition:
                                                    SnackPosition.TOP,
                                                duration:
                                                    const Duration(seconds: 3),
                                                colorText: mainWhite,
                                                backgroundColor: mainBlack);
                                          });
                                        },
                                      );
                                    },
                                    child: _progress != null
                                        ? const CircularProgressIndicator()
                                        : const Icon(
                                            Icons.download,
                                            size: 40,
                                            color: mainWhite,
                                          ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 15.0),
                                  child: AnimatedBuilder(
                                    animation: _animationController,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        SizedBox(
                                          height: 50,
                                          width: 50,
                                          child: Image.asset("images/disc.png"),
                                        ),
                                        CircleAvatar(
                                          radius: 12,
                                          backgroundImage:
                                              NetworkImage(data.profileImage!),
                                        )
                                      ],
                                    ),
                                    builder: (context, child) {
                                      return Transform.rotate(
                                        angle:
                                            2 * pi * _animationController.value,
                                        child: child,
                                      );
                                    },
                                  ),
                                )
                              ],
                            )),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        );
      }),
    );
  }

  _sideBarItem(IconData iconName, Color iconColor, press(), String label,
      TextStyle style) {
    return InkWell(
      onTap: () {
        press();
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 15.0),
        child: Column(
          children: [
            Icon(
              iconName,
              size: 40,
              color: iconColor,
            ),
            Text(label, style: style),
          ],
        ),
      ),
    );
  }

  _profileImageButton(String profileImage, profile(), follow()) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          InkWell(
            onTap: () {
              profile();
            },
            child: Container(
              height: 50,
              width: 50,
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 3),
                borderRadius: BorderRadius.circular(25),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image(
                  image: NetworkImage(profileImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -15,
            child: GestureDetector(
              onTap: () {
                follow();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Icon(
                  Icons.add,
                  size: 25,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
