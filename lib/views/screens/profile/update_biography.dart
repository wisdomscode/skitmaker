import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skitmaker/constants/colors.dart';
import 'package:skitmaker/constants/constance.dart';
import 'package:skitmaker/views/screens/profile/profile_page.dart';
import 'package:skitmaker/views/widgets/icon_button_widget.dart';
import 'package:skitmaker/views/widgets/large_text.dart';

class BiographyUpdate extends StatefulWidget {
  const BiographyUpdate({super.key, required this.biography});
  final String biography;

  @override
  State<BiographyUpdate> createState() => _BiographyUpdateState();
}

class _BiographyUpdateState extends State<BiographyUpdate> {
  final TextEditingController _biographyController = TextEditingController();

  @override
  void initState() {
    _biographyController.value = TextEditingValue(text: widget.biography);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
          color: lightBlack,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35),
            topRight: Radius.circular(35),
          )),
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Center(
                child: Container(
                  width: 70,
                  height: 5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2), color: darkGrey),
                ),
              ),
            ),
            const SizedBox(height: 20),
            LargeTextWidget(text: 'Biography', textSize: 20),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: TextFormField(
                controller: _biographyController,
                style: const TextStyle(color: grayWhite),
                maxLines: 6,
                decoration: InputDecoration(
                  label: const Text(
                    'Enter your Personal Summary',
                    style: TextStyle(
                        color: mainRed,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide:
                          const BorderSide(color: borderColor, width: 1)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide:
                          const BorderSide(color: borderColor, width: 1)),
                  fillColor: lightBlack,
                  filled: true,
                  // hintText: 'Personal Summary',
                  hintStyle: const TextStyle(color: grayWhite),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(56),
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black,
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.send, size: 28),
                        SizedBox(width: 15),
                        Text(
                          "Update Biography",
                        ),
                      ]),
                  onPressed: () {
                    Navigator.pop(context);
                    authController.updateBiography(
                      _biographyController.text,
                    );
                  },
                ))
          ],
        ),
      ),
    );
  }
}
