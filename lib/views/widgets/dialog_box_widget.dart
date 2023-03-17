import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

class DialogBoxWidget extends StatelessWidget {
  DialogBoxWidget({
    super.key,
    this.title,
    this.content,
    required this.firstActionWidget,
    required this.secondActionWidget,
    required this.openDialogMessage,
  });

  String? title;
  String? content;
  Widget firstActionWidget;
  Widget secondActionWidget;
  Widget openDialogMessage;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return TextButton(
      onPressed: () => showAnimatedDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return ClassicGeneralDialogWidget(
            titleText: title,
            contentText: content,
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: SizedBox(width: size.width*0.9, child: firstActionWidget),
              ), 
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: SizedBox(width: size.width*0.9,child: secondActionWidget,),
              ),
            ],
          );
        },
        animationType: DialogTransitionType.fadeScale,
        curve: Curves.fastOutSlowIn,
        duration: Duration(seconds: 1),
      ),
      child: openDialogMessage,
    );
  }

}
