import 'package:flutter/material.dart';
import 'package:skitmaker/views/widgets/small_box_widget.dart';

class InterestListViewWidget extends StatelessWidget {
  InterestListViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var interests = [
      'Action',
      'Drama',
      'Comedy',
      'Horror',
      'Adventure',
      'Sports',
      'Romance',
      'Science',
      'Music',
      'Documentary',
      'Crime',
      'Fantasy',
      'Mystery',
      'Fiction',
      'Animation',
      'War',
      'History',
      'Television',
      'Superheroes',
      'Anime',
      'Thriller',
      'K-Drama',
      'Catoons',
      'Kiddies'
    ];

    // var textList = interests.map<Text>((e) => Text(e)).toList();
    var textList = interests
        .map<SmallBoxWidget>((item) => SmallBoxWidget(
              getSelectedItem: () {},
              isSelectedBox: false,
              titleText: item,
            ))
        .toList();

    return SingleChildScrollView(
      child: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 4,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        shrinkWrap: true,
        children: textList,
      ),
    );
  }
}
