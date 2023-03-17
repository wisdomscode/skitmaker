import 'package:flutter/material.dart';
import 'package:skitmaker/constants/colors.dart';
import 'package:skitmaker/views/widgets/normal_text.dart';

class SmallBoxWidget extends StatefulWidget {
  SmallBoxWidget({
    super.key,
    required this.titleText,
    required this.isSelectedBox,
    required this.getSelectedItem,
  });

  final String titleText;
  final bool isSelectedBox;

  Function getSelectedItem;

  @override
  State<SmallBoxWidget> createState() => _SmallBoxWidgetState();
}

class _SmallBoxWidgetState extends State<SmallBoxWidget> {
  bool isSelected = false;

  @override
  void initState() {
    isSelected = widget.isSelectedBox;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        widget.getSelectedItem();
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: Container(
        width: size.width * 0.45,
        height: 38,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(19)),
          gradient: isSelected
              ? null
              : LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [mainRed, mainYellow]),
        ),
        child: Container(
          width: size.width * 0.45,
          height: 32,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            color: isSelected ? mainRed : lightBlack,
          ),
          alignment: Alignment.center,
          child: NormalTextWidget(text: widget.titleText, textSize: 16),
        ),
      ),
    );
  }
}
