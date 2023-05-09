import 'package:flutter/material.dart';
import 'package:skitmaker/constants/colors.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:skitmaker/views/screens/skits/get_photo.dart';
import 'package:skitmaker/views/screens/skits/get_video.dart';
import 'package:skitmaker/views/widgets/circular_gradient_icon_widget.dart';
import 'package:skitmaker/views/widgets/large_text.dart';
import 'package:skitmaker/views/widgets/normal_text.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    super.key,
    required this.selectedPageIndex,
    required this.onIconTap,
  });

  final int selectedPageIndex;
  final Function onIconTap;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context)
        .textTheme
        .bodyText1!
        .copyWith(fontSize: 11, fontWeight: FontWeight.w600);

    return BottomAppBar(
      color: lightBlack,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.only(top: 7, bottom: 10),
        child: SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _bttomBarNavItem(
                  0, 'Home', style, IconlyBold.home, IconlyLight.home),
              _bttomBarNavItem(
                  1, 'Trendy', style, Icons.yard, Icons.yard_outlined),
              _addVideoNavItem(50, context),
              _bttomBarNavItem(3, 'Quicky', style, Icons.emoji_emotions,
                  Icons.emoji_emotions_outlined),
              _bttomBarNavItem(
                  4, 'Save', style, IconlyBold.download, IconlyLight.download),
            ],
          ),
        ),
      ),
    );
  }

  _bttomBarNavItem(
    int index,
    String label,
    TextStyle textStyle,
    IconData selectedIconData,
    IconData unselectedIconData,
  ) {
    bool isSelected = selectedPageIndex == index;
    Color iconAndTextColor = isSelected ? mainWhite : Colors.grey;

    if (isSelected && selectedPageIndex == 0) {
      iconAndTextColor = mainWhite;
    }
    return GestureDetector(
      onTap: () {
        onIconTap(index);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isSelected ? selectedIconData : unselectedIconData,
            color: iconAndTextColor,
            size: 30,
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: textStyle.copyWith(color: iconAndTextColor),
          ),
        ],
      ),
    );
  }

  _addVideoNavItem(double height, BuildContext context) {
    return GestureDetector(
      onTap: () {
        showBottomSheet(
          context: context,
          backgroundColor: Colors.black.withOpacity(0.8),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          )),
          builder: (BuildContext context) {
            return SizedBox(
              height: 270,
              // width: double.infinity,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, top: 10, right: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        LargeTextWidget(text: 'Create New Skit', textSize: 18),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.close, color: mainWhite),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                    ),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            showVideoOptionsDialog(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                CircularGradientIconWidget(
                                  icon: Icons.camera,
                                  outerBorderHeight: 40,
                                  outerBorderWidth: 40,
                                  innerBorderHeight: 37,
                                  innerBorderWidth: 37,
                                ),
                                SizedBox(width: 10),
                                NormalTextWidget(
                                  text: 'Create Video Skit',
                                  textSize: 18,
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            showImageOptionsDialog(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Row(
                              children: [
                                CircularGradientIconWidget(
                                  icon: Icons.cloud_upload_outlined,
                                  outerBorderHeight: 40,
                                  outerBorderWidth: 40,
                                  innerBorderHeight: 37,
                                  innerBorderWidth: 37,
                                ),
                                SizedBox(width: 10),
                                NormalTextWidget(
                                  text: 'Create Photo Skit',
                                  textSize: 18,
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            print('Go live clicked');
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                CircularGradientIconWidget(
                                  icon: Icons.online_prediction_sharp,
                                  outerBorderHeight: 40,
                                  outerBorderWidth: 40,
                                  innerBorderHeight: 37,
                                  innerBorderWidth: 37,
                                ),
                                SizedBox(width: 10),
                                NormalTextWidget(
                                  text: 'Go Live',
                                  textSize: 18,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20)
                ],
              ),
            );
          },
        );
      },
      child: CircularGradientIconWidget(
        icon: Icons.add,
      ),
    );
  }
}
