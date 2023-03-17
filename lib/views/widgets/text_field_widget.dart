import 'package:flutter/material.dart';
import 'package:skitmaker/constants/colors.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget(
      {Key? key,
      required this.fieldName,
      this.prefixIcon,
      this.hintText,
      this.suffixIcon,
      required this.controller,
      this.maxLines})
      : super(key: key);

  final String fieldName;
  final String? hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final TextEditingController controller;
  final int? maxLines;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: TextFormField(
        controller: widget.controller,
        style: const TextStyle(color: grayWhite, fontWeight: FontWeight.bold),
        maxLines: widget.maxLines,
        decoration: InputDecoration(
          label: Text(
            widget.fieldName,
            style: const TextStyle(color: grayWhite),
          ),
          prefixIcon: Icon(
            widget.prefixIcon,
            color: grayWhite,
          ),
          suffixIcon: Icon(
            widget.suffixIcon,
            color: grayWhite,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: borderColor, width: 1)
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: borderColor, width: 1)
          ),
          fillColor: lightBlack,
          filled: true,
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: grayWhite),
        ),
      ),
    );
  }
}
