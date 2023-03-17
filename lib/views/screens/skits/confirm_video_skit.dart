import 'dart:io';

import 'package:flutter/material.dart';
import 'package:skitmaker/constants/colors.dart';
import 'package:skitmaker/controllers/upload_video_controller.dart';
import 'package:skitmaker/navigation_container.dart';
import 'package:skitmaker/views/screens/skits/components/category_select.dart';
import 'package:skitmaker/views/screens/skits/skit_home_page.dart';
import 'package:skitmaker/views/widgets/circular_gradient_icon_widget.dart';
import 'package:skitmaker/views/widgets/large_text.dart';
import 'package:skitmaker/views/widgets/normal_text.dart';
import 'package:skitmaker/views/widgets/primary_button_widget.dart';
import 'package:skitmaker/views/widgets/secondary_button.dart';
import 'package:skitmaker/views/widgets/text_field_widget.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class ConfirmShortSkitPage extends StatefulWidget {
  const ConfirmShortSkitPage({
    super.key,
    required this.videoFile,
    required this.videoPath,
    required this.dimension,
  });

  final File videoFile;
  final String videoPath;
  final String dimension;

  @override
  State<ConfirmShortSkitPage> createState() => _ConfirmShortSkitPageState();
}

class _ConfirmShortSkitPageState extends State<ConfirmShortSkitPage> {
  late VideoPlayerController videoControler;
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var tagController = TextEditingController();

  // initialize UploadVideoController
  UploadVideoController uploadVideoController =
      Get.put(UploadVideoController());

  bool _isVideoPlaying = true;
  @override
  void initState() {
    super.initState();
    setState(() {
      videoControler = VideoPlayerController.file(widget.videoFile);
    });
    videoControler.initialize();
    videoControler.setVolume(1);
    videoControler.setLooping(true);
  }

  @override
  void dispose() {
    videoControler.dispose();
    super.dispose();
  }

  void _pausePlayVideo() {
    _isVideoPlaying ? videoControler.pause() : videoControler.play();
    setState(() {
      _isVideoPlaying = !_isVideoPlaying;
    });
  }

  _ConfirmVideoSkitPageState() {
    _selectedCategory = categoryList[0];
  }

  // select category
  List<String> categoryList = [
    'General',
    'Comedy',
    'Politics',
    'Music',
    'Sports',
    'Kids',
    'Funny',
    'Horror',
  ];

  String? _selectedCategory = 'General';

  String? skitType;

  bool isLoading = false;

  // bool isDesktop(BuildContext context) =>
  //     MediaQuery.of(context).size.width >= 600;
  // bool isMobile(BuildContext context) =>
  //     MediaQuery.of(context).size.width < 600;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBlack,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                _pausePlayVideo();
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  widget.dimension == 'video-skit'
                      ? SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 3.0,
                          child: VideoPlayer(videoControler))
                      : SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 1.2,
                          child: VideoPlayer(videoControler),
                        ),
                  IconButton(
                    onPressed: () {
                      _pausePlayVideo();
                    },
                    icon: Icon(
                      Icons.play_arrow,
                      color:
                          Colors.white.withOpacity(_isVideoPlaying ? 0 : 0.9),
                      size: 60,
                    ),
                  ),
                  Positioned.fill(
                    bottom: 0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        VideoProgressIndicator(
                          videoControler,
                          allowScrubbing: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextFieldWidget(
                    fieldName: 'Skit title',
                    controller: titleController,
                    prefixIcon: Icons.music_note,
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: DropdownButtonFormField(
                      value: _selectedCategory,
                      items: categoryList
                          .map(
                              (e) => DropdownMenuItem(child: Text(e), value: e))
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          _selectedCategory = val as String;
                        });
                      },
                      style: const TextStyle(color: mainWhite),
                      icon: const Icon(
                        Icons.arrow_drop_down_circle,
                        color: mainWhite,
                      ),
                      dropdownColor: lightBlack,
                      decoration: const InputDecoration(
                        label: Text(
                          'Category',
                          style: TextStyle(color: mainWhite),
                        ),
                        prefixIcon: Icon(
                          Icons.category,
                          color: mainWhite,
                        ),
                        border: OutlineInputBorder(),
                        fillColor: lightBlack,
                        filled: true,
                        hintStyle: TextStyle(color: mainWhite),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextFieldWidget(
                    fieldName: 'Skit Description',
                    controller: descriptionController,
                    prefixIcon: Icons.message,
                  ),
                  TextFieldWidget(
                    fieldName: 'Tags',
                    controller: tagController,
                    prefixIcon: Icons.tag,
                  ),
                  const SizedBox(height: 10),
                  isLoading
                      ? const CircularProgressIndicator()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SecondaryButtomWidget(
                              btnText: 'Cancel',
                              press: () {
                                Get.to(() => const NavigationContainer());
                              },
                              buttonWidth: 120,
                            ),
                            const SizedBox(width: 20),
                            MainButtomWidget(
                              active: true,
                              btnText: 'Share Short Skit',
                              press: () {
                                setState(() {
                                  isLoading = true;
                                });
                                uploadVideoController.uploadVideo(
                                  titleController.text,
                                  descriptionController.text,
                                  widget.videoPath,
                                  _selectedCategory,
                                  tagController.text,
                                  skitType = widget.dimension,
                                );
                              },
                              buttonWidth: 180,
                              textSize: 16,
                            ),
                          ],
                        ),
                  const SizedBox(height: 30),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
