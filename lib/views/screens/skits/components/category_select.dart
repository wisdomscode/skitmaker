import 'package:flutter/material.dart';

import 'package:skitmaker/constants/colors.dart';

class CategorySelectOption extends StatefulWidget {
  const CategorySelectOption({super.key});

  @override
  State<CategorySelectOption> createState() => _CategorySelectOptionState();
}

class _CategorySelectOptionState extends State<CategorySelectOption> {
  

  _CategorySelectOptionState() {
    _selectedVal = categoryList[0];
  }
  List<String> categoryList = [
    'General',
    'Music',
    'Kids',
    'Funny',
    'Horror',
    'Sports',
  ];

  String? _selectedVal = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(
        children: [
          DropdownButtonFormField(
            value: _selectedVal,
            items: categoryList
                .map((e) =>
                    DropdownMenuItem(child: Text(e), value: e))
                .toList(),
            onChanged: (val) {
              setState(() {
                _selectedVal = val as String;
              });
            },
            style: const TextStyle(color: mainWhite),
            icon: const Icon(
              Icons.arrow_drop_down_circle,
              color: mainWhite,
            ),
            dropdownColor: lightBlack,
            decoration: const InputDecoration(
                label: Text('Category'),
                prefixIcon: Icon(
                  Icons.accessibility_new_rounded,
                  color: mainWhite,
                ),
                border: OutlineInputBorder(),
                fillColor: lightBlack,
                filled: true,
                hintStyle: TextStyle(color: mainWhite)),
          ),
        ],
      )),
    );
  }
}