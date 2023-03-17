import 'package:flutter/material.dart';
import 'package:skitmaker/constants/colors.dart';

class SkitCategoryItem extends StatefulWidget {
  const SkitCategoryItem({
    super.key,
  });

  @override
  State<SkitCategoryItem> createState() => _SkitCategoryItemState();
}

class _SkitCategoryItemState extends State<SkitCategoryItem> {
  List<String> categories = [
    'All',
    'Music',
    'Kids',
    'Funny',
    'Horror',
    'Sports',
  ];

  int current = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: categories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: ((cntx, index) {
          return Column(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    current = index;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  margin: const EdgeInsets.all(5),
                  // width: 80,
                  height: 30,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                  decoration: BoxDecoration(
                    color: current == index ? mainWhite : lightBlack,
                    borderRadius: current == index
                        ? BorderRadius.circular(7)
                        : BorderRadius.circular(15),
                    border: current == index
                        ? null
                        : Border.all(width: 2, color: mainWhite),
                  ),
                  child: Center(
                      child: Text(
                    categories[index],
                    style: TextStyle(
                        fontWeight: current == index ? FontWeight.bold : null,
                        color: current == index ? mainBlack : grayWhite),
                  )),
                ),
              ),

              /// Bottom Indicator
              Visibility(
                visible: current == index,
                child: Container(
                  width: 5,
                  height: 5,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
