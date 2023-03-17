import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:skitmaker/constants/colors.dart';
import 'package:skitmaker/controllers/skit_controller.dart';
import 'package:skitmaker/views/screens/skits/components/skit_category_item.dart';
import 'package:skitmaker/views/screens/skits/single_movie_skit.dart';
import 'package:skitmaker/views/widgets/bottom_modal_item.dart';
import 'package:skitmaker/views/widgets/custom_appbar_widget.dart';
import 'package:get/get.dart';
import 'package:skitmaker/views/widgets/normal_text.dart';
import 'package:timeago/timeago.dart' as tago;

class SkitHomePage extends StatefulWidget {
  SkitHomePage({super.key});

  final SkitController skitController = Get.put(SkitController());

  @override
  State<SkitHomePage> createState() => _SkitHomePageState();
}

class _SkitHomePageState extends State<SkitHomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: mainBlack,
      appBar: const CustomAppBarWidget(),
      body: SizedBox(
        child: Column(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8.0, top: 0, bottom: 10),
                      child: IconButton(
                        icon: const Icon(
                          Icons.gps_fixed,
                          color: mainWhite,
                          size: 30,
                        ),
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.8,
                      child: SkitCategoryItem(),
                    ),
                  ],
                ),
              ],
            ),

            /// Main Body

            Expanded(
              child: SizedBox(
                width: double.infinity,
                height: size.height * 0.74,
                child: Obx(() {
                  return ListView.builder(
                    itemCount: widget.skitController.videoSkitList.length,
                    itemBuilder: (context, index) {
                      var data = widget.skitController.videoSkitList[index];

                      return GestureDetector(
                        onTap: () {
                          Get.to(
                            () => SingleVideoPage(data: data),
                          );
                        },
                        child: SizedBox(
                          height: 270,
                          width: double.infinity,
                          child: Column(
                            children: [
                              SizedBox(
                                child: Image.network(
                                      data.thumbnail!,
                                      height: 190,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ) ??
                                    const SizedBox(
                                        height: 190,
                                        child: CircularProgressIndicator()),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10.0, top: 10),
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                          data.profileImage!,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: size.width * 0.67,
                                          child: Text(
                                            data.skitTitle!,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: const TextStyle(
                                              color: mainWhite,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 5),

                                        NormalTextWidget(
                                          text: "@${data.username}",
                                          textColor: Colors.white,
                                        ),
                                        const SizedBox(height: 5),

                                        // NormalTextWidget(
                                        //     text: data.category!,
                                        //     textColor: Colors.grey.shade500),
                                        Row(
                                          children: [
                                            NormalTextWidget(
                                              text:
                                                  "${data.likes.length.toString()} likes",
                                              textColor: Colors.grey.shade500,
                                            ),
                                            const SizedBox(width: 15),
                                            NormalTextWidget(
                                              text: tago.format(
                                                  data.dateCreated.toDate()),
                                              textColor: Colors.grey.shade500,
                                            )
                                            // check date
                                          ],
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: IconButton(
                                        icon: const Icon(Icons.more_vert,
                                            color: mainWhite, size: 24),
                                        onPressed: () {
                                          showModalBottomSheet(
                                            backgroundColor: Colors.transparent,
                                            barrierColor: Colors.black54,
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Container(
                                                // height: 600,
                                                decoration: BoxDecoration(
                                                    color: Colors.black
                                                        .withOpacity(0.8),
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(35),
                                                      topRight:
                                                          Radius.circular(35),
                                                    )),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 20.0),
                                                        child: Center(
                                                          child: Container(
                                                            width: 70,
                                                            height: 5,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            2),
                                                                color:
                                                                    darkGrey),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 20),
                                                      CustomBottomModalList(
                                                        icon: IconlyLight
                                                            .timeCircle,
                                                        text:
                                                            'Save to watch later',
                                                        onListTap: () {},
                                                      ),
                                                      CustomBottomModalList(
                                                        icon: IconlyLight.plus,
                                                        text:
                                                            'Save to Playlist',
                                                        onListTap: () {},
                                                      ),
                                                      CustomBottomModalList(
                                                        icon: IconlyLight
                                                            .download,
                                                        text: 'Download video',
                                                        onListTap: () {},
                                                      ),
                                                      CustomBottomModalList(
                                                        icon: IconlyLight.send,
                                                        text: 'Share',
                                                        onListTap: () {},
                                                      ),
                                                      CustomBottomModalList(
                                                        icon: Icons.block,
                                                        text: 'Not Interested',
                                                        onListTap: () {},
                                                      ),
                                                      CustomBottomModalList(
                                                        icon: Icons.block,
                                                        text:
                                                            'Don\'t recommend Channel',
                                                        onListTap: () {},
                                                      ),
                                                      CustomBottomModalList(
                                                        icon: Icons.report,
                                                        text: 'Report',
                                                        onListTap: () {},
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
