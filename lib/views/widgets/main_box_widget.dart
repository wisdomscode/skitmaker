import 'package:flutter/material.dart';
import 'package:skitmaker/constants/colors.dart';
import 'package:skitmaker/views/widgets/normal_text.dart';

class MainBoxWidget extends StatefulWidget {
  MainBoxWidget({
    super.key,
    required this.viaText,
    required this.detailText,
    this.icon,
    required this.isSelectedBox,
    required this.getSelectedItem,
  });

  final String viaText;
  final String detailText;
  final IconData? icon;
  final bool isSelectedBox;

  Function getSelectedItem;

  @override
  State<MainBoxWidget> createState() => _MainBoxWidgetState();
}

class _MainBoxWidgetState extends State<MainBoxWidget> {
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
        width: size.width,
        height: 80,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          gradient: isSelected
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [mainRed, mainYellow])
              : null,
        ),
        child: Container(
          width: size.width * 0.96,
          height: 76,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(14)),
            color: lightBlack,
          ),
          alignment: Alignment.center,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: CircleAvatar(
                  child: Icon(widget.icon),
                  backgroundColor: Colors.brown.shade600,
                  foregroundColor: Colors.white,
                  radius: 25,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NormalTextWidget(text: widget.viaText),
                    const SizedBox(height: 8),
                    NormalTextWidget(text: widget.detailText)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
