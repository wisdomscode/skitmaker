import 'package:flutter/material.dart';
import 'package:skitmaker/constants/colors.dart';

class RememberMeCheckox extends StatefulWidget {
  RememberMeCheckox({
    super.key,
    required this.isChecked,
    this.size,
    this.checkSize,
    this.selectedColor,
    this.selectedCheckColor,
    required this.textLabel,
    this.textColor,
    this.textSize,
  });

  bool isChecked;
  final double? size;
  final double? checkSize;
  final Color? selectedColor;
  final Color? selectedCheckColor;
  final String textLabel;
  final Color? textColor;
  final double? textSize;

  @override
  State<RememberMeCheckox> createState() => _RememberMeCheckoxState();
}

class _RememberMeCheckoxState extends State<RememberMeCheckox> {
  bool is_selected = false;

  @override
  void initState() {
    is_selected = widget.isChecked;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(10),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: lightBlack,
        child: InkWell(
          onTap: () {
            setState(() {
              is_selected = !is_selected;
            });
          },
          splashColor: mainWhite,
          child: SizedBox(
            width: size.width * 0.7,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.fastLinearToSlowEaseIn,
                  decoration: BoxDecoration(
                    color: is_selected
                        ? widget.selectedColor ?? Colors.blue
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(5.0),
                    border: is_selected
                        ? null
                        : Border.all(color: mainRed, width: 2.0),
                  ),
                  width: widget.size ?? 30,
                  height: widget.size ?? 30,
                  child: is_selected
                      ? Icon(
                          Icons.check,
                          color: widget.selectedCheckColor ?? Colors.white,
                          size: widget.checkSize ?? 25,
                        )
                      : null,
                ),
                SizedBox(width: 20),
                Text(
                  widget.textLabel,
                  style: TextStyle(
                    color: widget.textColor ?? Colors.black,
                    fontSize: widget.textSize ?? 20,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
