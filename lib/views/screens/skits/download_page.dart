import 'package:flutter/material.dart';
import 'package:skitmaker/constants/colors.dart';
import 'package:skitmaker/navigation_container.dart';
import 'package:skitmaker/views/screens/skits/components/skit-downlaoded_items_list.dart';
import 'package:skitmaker/views/screens/skits/skit_home_page.dart';
import 'package:skitmaker/views/widgets/go_back_button.dart';
import 'package:skitmaker/views/widgets/large_text.dart';
import 'package:skitmaker/views/widgets/navigation_icon_button.dart';
import 'package:get/get.dart';

class DownloadPage extends StatelessWidget {
  const DownloadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBlack,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: LargeTextWidget(
              text: 'Downloads',
              textSize: 24,
              textColor: mainWhite,
            ),
          ),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: SkitDownlaodedItemList(),
            ),
          ),
        ],
      ),
    );
  }
}
