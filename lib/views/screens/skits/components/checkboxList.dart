import 'package:flutter/material.dart';

class PhotoSkit extends StatefulWidget {
  const PhotoSkit({super.key});

  @override
  State<PhotoSkit> createState() => _PhotoSkitState();
}

bool _checkboxValue = false;

class _PhotoSkitState extends State<PhotoSkit> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('data'),
        CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          title: Text('Photo Skit'),
          value: _checkboxValue,
          onChanged: (value) {
            setState(() {
              _checkboxValue = !_checkboxValue;
            });
          },
        ),
      ],
    );
  }
}
