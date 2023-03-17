import 'dart:math';

import 'package:flutter/material.dart';
import 'package:skitmaker/constants/colors.dart';
import 'package:skitmaker/models/skit_model.dart';

class SideActionToolBar extends StatefulWidget {
  const SideActionToolBar({
    Key? key,
    required this.skit,
  }) : super(key: key);

  final Skit skit;

  @override
  State<SideActionToolBar> createState() => _SideActionToolBarState();
}

class _SideActionToolBarState extends State<SideActionToolBar>
    with SingleTickerProviderStateMixin {
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

  @override
  Widget build(BuildContext context) {
    TextStyle style = Theme.of(context)
        .textTheme
        .bodyText1!
        .copyWith(fontSize: 13, color: Colors.white);
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _profileImageButton(widget.skit.skitUrl!),
          _sideBarItem(Icons.favorite, widget.skit.likes.toString(), style),
          _sideBarItem(
              Icons.chat_rounded, widget.skit.commentCount.toString(), style),
          _sideBarItem(Icons.folder_special, 'My List', style),
          _sideBarItem(Icons.share, 'Share', style),
          AnimatedBuilder(
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
                    backgroundImage: AssetImage(widget.skit.skitUrl!),
                  )
                ],
              ),
              builder: (context, child) {
                return Transform.rotate(
                  angle: 2 * pi * _animationController.value,
                  child: child,
                );
              })
        ],
      ),
    );
  }

  _sideBarItem(IconData iconName, String label, TextStyle style) {
    return Column(
      children: [
        Icon(
          iconName,
          size: 40,
          color: Colors.white.withOpacity(0.75),
        ),
        // const SizedBox(height: 3),
        Text(label, style: style),
      ],
    );
  }

  _profileImageButton(String skitUrl) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 3),
            borderRadius: BorderRadius.circular(25),
            image: DecorationImage(
              image: AssetImage(
                skitUrl,
              ),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Positioned(
          bottom: -10,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(25),
            ),
            child: const Icon(
              Icons.add,
              size: 20,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
