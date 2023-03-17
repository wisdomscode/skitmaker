import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:skitmaker/constants/colors.dart';
import 'package:skitmaker/models/skit_model.dart';
import 'package:marquee/marquee.dart';

class VideoDescription extends StatelessWidget {
  const VideoDescription({
    Key? key,
    required this.skit,
  }) : super(key: key);

  final Skit skit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text("@${skit.username}",
            style:
                const TextStyle(fontWeight: FontWeight.w900, color: mainWhite)),
        const SizedBox(height: 10),
        ExpandableText(
          skit.description!,
          expandText: 'See more',
          collapseText: '  ...Less',
          expandOnTextTap: true,
          collapseOnTextTap: true,
          maxLines: 2,
          linkColor: mainWhite,
          style: const TextStyle(color: grayWhite),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const Icon(
              Icons.music_note,
              size: 18.0,
              color: mainWhite,
            ),
            const SizedBox(width: 8),
            SizedBox(
              height: 20,
              width: MediaQuery.of(context).size.width / 2,
              child: Marquee(
                text: '${skit.skitTitle}   -   ',
                velocity: 10,
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: mainWhite),
              ),
            )
          ],
        )
      ],
    );
  }
}
