import 'dart:io';

import 'package:flutter/material.dart';
import 'package:skitmaker/constants/colors.dart';
import 'package:skitmaker/views/screens/skits/confirm_video_skit.dart';
import 'package:skitmaker/views/widgets/circular_gradient_icon_widget.dart';
import 'package:skitmaker/views/widgets/large_text.dart';
import 'package:skitmaker/views/widgets/normal_text.dart';
import 'package:image_picker/image_picker.dart';

Future showVideoOptionsDialog(BuildContext context) {
  pickVideo(ImageSource src, String dimension, BuildContext context) async {
    final video = await ImagePicker().pickVideo(source: src);

    if (video != null) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) {
          return ConfirmShortSkitPage(
            videoFile: File(video.path),
            videoPath: video.path,
            dimension: dimension,
          );
        }),
      );
    }
  }

  return showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      backgroundColor: lightBlack.withOpacity(0.8),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          LargeTextWidget(
              text: 'Create Short Skit', textSize: 18, textColor: mainWhite),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.close, color: mainWhite),
          ),
        ],
      ),
      children: [
        SimpleDialogOption(
          onPressed: () {
            pickVideo(ImageSource.camera, 'short-skit', context);
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: mainBlack,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: [
                CircularGradientIconWidget(
                  icon: Icons.camera_alt,
                  outerBorderHeight: 35,
                  outerBorderWidth: 35,
                  innerBorderHeight: 33,
                  innerBorderWidth: 33,
                  IconSize: 20,
                ),
                const SizedBox(width: 20),
                NormalTextWidget(
                  text: 'From Camera',
                  textSize: 16,
                )
              ],
            ),
          ),
        ),
        SimpleDialogOption(
          onPressed: () {
            pickVideo(ImageSource.gallery, 'video-skit', context);
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: mainBlack,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: [
                CircularGradientIconWidget(
                  icon: Icons.video_camera_front_outlined,
                  outerBorderHeight: 35,
                  outerBorderWidth: 35,
                  innerBorderHeight: 33,
                  innerBorderWidth: 33,
                  IconSize: 20,
                ),
                const SizedBox(width: 20),
                NormalTextWidget(
                  text: 'From Gallery',
                  textSize: 16,
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
