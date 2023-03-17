import 'package:flutter/material.dart';
import 'package:skitmaker/constants/mock_data.dart';
import 'package:skitmaker/views/screens/skits/components/widgets/skit_download_item.dart';

class SkitDownlaodedItemList extends StatefulWidget {
  const SkitDownlaodedItemList({
    Key? key,
  }) : super(key: key);

  @override
  State<SkitDownlaodedItemList> createState() => _SkitDownlaodedItemListState();
}

class _SkitDownlaodedItemListState extends State<SkitDownlaodedItemList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: skits.length,
      itemBuilder: (context, index) {
        return SkitDownLoadItem(skit: skits[index]);
      },
    );
  }
}
