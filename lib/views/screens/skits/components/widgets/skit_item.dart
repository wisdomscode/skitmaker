// import 'package:flutter/material.dart';
// import 'package:flutter_iconly/flutter_iconly.dart';
// import 'package:skitmaker/constants/colors.dart';
// import 'package:skitmaker/constants/mock_data.dart';
// import 'package:skitmaker/controllers/skit_controller.dart';
// import 'package:skitmaker/models/skit_model.dart';
// import 'package:skitmaker/views/screens/skits/single_skit_video.dart';
// import 'package:skitmaker/views/widgets/bottom_modal_item.dart';
// import 'package:skitmaker/views/widgets/normal_text.dart';
// import 'package:get/get.dart';

// class SkitItemWidget extends StatefulWidget {
//   SkitItemWidget({super.key, required this.skit});

//   final Skit skit;

//   final SkitController videoController = Get.put(SkitController());

//   @override
//   State<SkitItemWidget> createState() => _SkitItemWidgetState();
// }

// class _SkitItemWidgetState extends State<SkitItemWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         // Get.to(() => SingleSkitVideoPage(), arguments: sampleSkit);
//       },
//       child: SizedBox(
//         height: 270,
//         width: double.infinity,
//         child: Column(
//           children: [
//             Image.asset(
//               widget.skit.thumbnail!,
//               height: 190,
//               width: double.infinity,
//               fit: BoxFit.cover,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 10.0, top: 10),
//               child: Row(
//                 children: [
//                   IconButton(
//                     onPressed: () {},
//                     icon: CircleAvatar(
//                       backgroundImage: AssetImage(
//                         widget.skit.profileImage!,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 5),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(
//                         width: MediaQuery.of(context).size.width * 0.66,
//                         child: Text(
//                           widget.skit.skitTitle!,
//                           overflow: TextOverflow.ellipsis,
//                           maxLines: 2,
//                           style: const TextStyle(
//                             color: mainWhite,
//                           ),
//                         ),
//                       ),
//                       NormalTextWidget(
//                           text: widget.skit.category!,
//                           textColor: Colors.grey.shade500),
//                       Text(
//                         "${widget.skit.username}  -  ${widget.skit.views} views  -  ${widget.skit.dateCreated} ago",
//                         style: TextStyle(
//                             color: Colors.grey.shade500, fontSize: 11),
//                         overflow: TextOverflow.ellipsis,
//                       )
//                     ],
//                   ),
//                   const Spacer(),
//                   IconButton(
//                     icon:
//                         const Icon(Icons.more_vert, color: mainWhite, size: 24),
//                     onPressed: () {
//                       showModalBottomSheet(
//                         backgroundColor: Colors.transparent,
//                         barrierColor: Colors.black54,
//                         context: context,
//                         builder: (BuildContext context) {
//                           return Container(
//                             // height: 600,
//                             decoration: BoxDecoration(
//                                 color: Colors.black.withOpacity(0.8),
//                                 borderRadius: const BorderRadius.only(
//                                   topLeft: Radius.circular(35),
//                                   topRight: Radius.circular(35),
//                                 )),
//                             child: Padding(
//                               padding: const EdgeInsets.only(left: 10.0),
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.only(top: 20.0),
//                                     child: Center(
//                                       child: Container(
//                                         width: 70,
//                                         height: 5,
//                                         decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(2),
//                                             color: darkGrey),
//                                       ),
//                                     ),
//                                   ),
//                                   const SizedBox(height: 20),
//                                   CustomBottomModalList(
//                                     icon: IconlyLight.timeCircle,
//                                     text: 'Save to watch later',
//                                     onListTap: () {
//                                       print('objectjjjjj');
//                                     },
//                                   ),
//                                   CustomBottomModalList(
//                                     icon: IconlyLight.plus,
//                                     text: 'Save to Playlist',
//                                     onListTap: () {},
//                                   ),
//                                   CustomBottomModalList(
//                                     icon: IconlyLight.download,
//                                     text: 'Download video',
//                                     onListTap: () {},
//                                   ),
//                                   CustomBottomModalList(
//                                     icon: IconlyLight.send,
//                                     text: 'Share',
//                                     onListTap: () {},
//                                   ),
//                                   CustomBottomModalList(
//                                     icon: Icons.block,
//                                     text: 'Not Interested',
//                                     onListTap: () {},
//                                   ),
//                                   CustomBottomModalList(
//                                     icon: Icons.block,
//                                     text: 'Don\'t recommend Channel',
//                                     onListTap: () {},
//                                   ),
//                                   CustomBottomModalList(
//                                     icon: Icons.report,
//                                     text: 'Report',
//                                     onListTap: () {},
//                                   ),
//                                   const SizedBox(height: 10),
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                       );
//                     },
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
