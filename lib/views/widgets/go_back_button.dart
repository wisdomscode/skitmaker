import 'package:flutter/material.dart';
import 'package:skitmaker/constants/colors.dart';
import 'package:get/get.dart';

class GoBackButtonWidget extends StatelessWidget {
  const GoBackButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: lightBlack,
      elevation: 8,
      borderRadius: BorderRadius.circular(25),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        onTap: () {
          Get.back();
        },
        splashColor: Colors.white,
        child: const SizedBox(
          width: 40,
          height: 40,
          child: Center(
            child: Icon(
              Icons.chevron_left,
              color: mainWhite,
            ),
          ),
        ),
      ),
    );
  }
}


// Padding(
//       padding: const EdgeInsets.only(left: 20.0),
//       child: Material(
//         color: lightBlack,
//         elevation: 8,
//         borderRadius: BorderRadius.circular(25),
//         clipBehavior: Clip.antiAliasWithSaveLayer,
//         child: InkWell(
//           onTap: () {
//             print('go back');
//             Get.back();
//           },
//           splashColor: mainWhite,
//           child: const SizedBox(
//             width: 50,
//             height: 50,
            // child: Icon(
            //   Icons.chevron_left,
            //   color: mainWhite,
            // ),
//           ),
//         ),
//       ),
//     );