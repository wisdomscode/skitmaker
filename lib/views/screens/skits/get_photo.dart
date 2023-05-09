import 'package:flutter/material.dart';
import 'dart:io';

import 'package:skitmaker/constants/colors.dart';
import 'package:skitmaker/views/screens/skits/components/checkboxList.dart';
import 'package:skitmaker/views/screens/skits/confirm_photo_skit.dart';
import 'package:skitmaker/views/widgets/circular_gradient_icon_widget.dart';
import 'package:skitmaker/views/widgets/large_text.dart';
import 'package:skitmaker/views/widgets/normal_text.dart';
import 'package:image_picker/image_picker.dart';

Future showImageOptionsDialog(BuildContext context) {
  pickImage(ImageSource src, BuildContext context) async {
    final video = await ImagePicker().pickVideo(source: src);

    if (video != null) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) {
          return ConfirmVideoSkitPage(
            videoFile: File(video.path),
            videoPath: video.path,
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
              text: 'Get Photo Skit', textSize: 18, textColor: mainWhite),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.close, color: mainWhite),
          ),
        ],
      ),
      children: [
        const PhotoSkit(),
        SimpleDialogOption(
          onPressed: () {
            pickImage(ImageSource.gallery, context);
          },
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: mainBlack,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: [
                CircularGradientIconWidget(
                  icon: Icons.image_rounded,
                  outerBorderHeight: 35,
                  outerBorderWidth: 35,
                  innerBorderHeight: 33,
                  innerBorderWidth: 33,
                  IconSize: 20,
                ),
                SizedBox(width: 20),
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
