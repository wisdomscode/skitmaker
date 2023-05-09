import 'package:flutter/material.dart';
import 'package:skitmaker/constants/colors.dart';
import 'package:skitmaker/models/skit_model.dart';
import 'package:skitmaker/views/widgets/normal_text.dart';

class SkitDownLoadItem extends StatefulWidget {
  const SkitDownLoadItem({super.key, required this.skit});

  final Skit skit;

  @override
  State<SkitDownLoadItem> createState() => _SkitDownLoadItemState();
}

class _SkitDownLoadItemState extends State<SkitDownLoadItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: double.infinity,
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Image.asset(
                  widget.skit.thumbnail!,
                  height: 100,
                  width: MediaQuery.of(context).size.width * 0.4,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Text(
                      widget.skit.skitTitle!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                        color: mainWhite,
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.38,
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            NormalTextWidget(
                                text: widget.skit.category!,
                                textColor: Colors.grey.shade500),
                            SizedBox(height: 5),
                            Text(
                              widget.skit.username,
                              style: TextStyle(
                                  color: Colors.grey.shade500, fontSize: 11),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: CircleAvatar(
                          backgroundImage: AssetImage(
                            widget.skit.profileImage!,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
