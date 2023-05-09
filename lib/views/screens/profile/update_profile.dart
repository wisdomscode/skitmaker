import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:skitmaker/constants/constance.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:skitmaker/views/widgets/dialog_box_widget.dart';
import 'package:skitmaker/views/widgets/go_back_button.dart';
import 'package:skitmaker/views/widgets/large_text.dart';

import 'package:skitmaker/constants/colors.dart';
import 'package:skitmaker/views/widgets/normal_text.dart';
import 'package:skitmaker/views/widgets/primary_button_widget.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

bool smsSelected = false;
bool emailSelected = false;

class UpdateUserProfilePage extends StatefulWidget {
  const UpdateUserProfilePage({super.key});

  @override
  State<UpdateUserProfilePage> createState() => _UpdateUserProfilePageState();
}

class _UpdateUserProfilePageState extends State<UpdateUserProfilePage> {
  /// image Variable
  File? imageFile;
  String profileImageUrl = '';

  // 1. Pick image:
  // install image_picker
  // import the corresponding library
  ImagePicker imagePicker = ImagePicker();

  pickImage(ImageSource source) async {
    final XFile? image = await imagePicker.pickImage(source: source);
    print('${image?.path}');

    // code to display selected image on UI and close select button
    if (image != null) {
      imageFile = File(image.path);
      setState(() {});
      Get.back();
    }

    if (image == null) return;

    // Create a referecnce to storage root
    Reference referenceRoot = FirebaseStorage.instance.ref();

    // Create referenceFolder
    Reference referenceDirImage = referenceRoot.child('profileImages');

    // Create a reference for the image to be stored
    // you can pass a child the image name as
    // string ("image_name")
    // local file ("${image?.path}")
    // or create a unique name using DateTime stamp
    // or use the user uid as in this case
    // String fileName = image.name;
    // String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

    String userUid = firebaseAuth.currentUser!.uid; // get currentUser id

    Reference referenceImageToUpload = referenceDirImage.child(userUid);

    try {
      // Store the file
      await referenceImageToUpload.putFile(File(image.path));

      // Success: get the downlaod URL
      profileImageUrl = await referenceImageToUpload.getDownloadURL();
      // print(profileImageUrl);
    } catch (e) {
      // Some error occured
    }
  }

  String initialCountry = 'NG';
  PhoneNumber number = PhoneNumber(isoCode: 'NG');

  void getPhoneNumber(String phoneNumber) async {
    PhoneNumber number =
        await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'NG');

    setState(() {
      this.number = number;
    });
  }

  var combinedPhone = '';

  @override
  void dispose() {
    phoneNumberController.dispose();
    super.dispose();
  }

  _UserProfilePageState() {
    _selectedVal = _genderList[0];
  }

  // check that username is not already taken
  doesUserExist(String username) async {
    dynamic noUser = await firestore
        .collection('users')
        .where("username", isEqualTo: username)
        .get()
        .then((value) {
      value.size > 0 ? true : false;
      print("No of users ${value.size}");
    });
    print('############  61');
    return noUser;
  }

  final _genderList = ['Male', 'Female'];

  String? _selectedVal = 'Male';

  var formKey = GlobalKey<FormState>();

  final docUid = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final fullnameController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final phoneNumberController = TextEditingController();

  // final args = Get.arguments;
  final args = Get.arguments;
  var newGender = '';
  var newProfileUrl = '';

  bool isLoading = false;

  DateTime dob = DateTime.now();

  // enable submit button
  bool submit = false;

  bool checkImage() {
    submit = profileImageUrl == '' ? false : true;
    return submit;
  }

  @override
  void initState() {
    docUid.value = TextEditingValue(text: args[0]['uid']);
    usernameController.value = TextEditingValue(text: args[1]['username']);
    emailController.value = TextEditingValue(text: args[2]['email']);
    fullnameController.value = TextEditingValue(text: args[3]['fullName']);
    dateOfBirthController.value = TextEditingValue(text: args[4]['dob']);
    phoneNumberController.value =
        TextEditingValue(text: args[5]['phoneNumber']);
    newGender = args[6]['gender'];
    newProfileUrl = args[7]['profileImage'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBlack,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Row(
                children: [
                  const GoBackButtonWidget(),
                  const SizedBox(width: 20),
                  Center(
                    child: LargeTextWidget(
                      text: 'Update Your Profile',
                      textSize: 20,
                    ),
                  ),
                ],
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            image: imageFile == null
                                ? const DecorationImage(
                                    image: AssetImage(
                                        "images/profiles/profile-2.png"),
                                    fit: BoxFit.fill)
                                : DecorationImage(
                                    image: FileImage(imageFile!),
                                    fit: BoxFit.fill),
                            color: mainBlack,
                            shape: BoxShape.circle,
                            border: Border.all(width: 5, color: lightBlack),
                          ),
                        ),
                        Positioned(
                          bottom: -10,
                          right: -5,
                          child: DialogBoxWidget(
                            title: 'Upload Photo',
                            content: 'Choose Image Source',
                            openDialogMessage: const Icon(Icons.add_a_photo),
                            firstActionWidget: ElevatedButton.icon(
                              icon: const Icon(Icons.image_outlined),
                              label: const Text('From Gallery'),
                              onPressed: () => pickImage(ImageSource.gallery),
                            ),
                            secondActionWidget: ElevatedButton.icon(
                              icon: const Icon(Icons.camera_alt_outlined),
                              label: const Text('From Camera'),
                              onPressed: () => pickImage(ImageSource.camera),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: NormalTextWidget(
                        text: '* You MUST Select an Image',
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Username
                    TextFormField(
                      controller: usernameController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Username CANNOT be empty';
                        }
                        return null;
                      },
                      style: const TextStyle(color: grayWhite),
                      decoration: const InputDecoration(
                        label: Text(
                          'Username',
                          style: TextStyle(color: grayWhite),
                        ),
                        prefixIcon: Icon(
                          Icons.star,
                          color: grayWhite,
                        ),
                        border: OutlineInputBorder(),
                        fillColor: lightBlack,
                        filled: true,
                        hintStyle: TextStyle(color: grayWhite),
                      ),
                    ),
                    const SizedBox(height: 15),
                    // email
                    TextFormField(
                      controller: emailController,
                      readOnly: true,
                      enabled: false,
                      style: const TextStyle(color: grayWhite),
                      decoration: const InputDecoration(
                        label: Text(
                          'Email',
                          style: TextStyle(color: grayWhite),
                        ),
                        prefixIcon: Icon(
                          Icons.email,
                          color: grayWhite,
                        ),
                        border: OutlineInputBorder(),
                        fillColor: lightBlack,
                        filled: true,
                        hintStyle: TextStyle(color: grayWhite),
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Name
                    TextFormField(
                      controller: fullnameController,
                      validator: (value) =>
                          value == "" ? "Please enter your name" : null,
                      style: const TextStyle(color: grayWhite),
                      decoration: const InputDecoration(
                        label: Text(
                          'Full Name',
                          style: TextStyle(color: grayWhite),
                        ),
                        prefixIcon: Icon(
                          Icons.person,
                          color: grayWhite,
                        ),
                        border: OutlineInputBorder(),
                        fillColor: lightBlack,
                        filled: true,
                        hintStyle: TextStyle(color: grayWhite),
                      ),
                    ),
                    const SizedBox(height: 15),

                    // date of birth
                    TextFormField(
                      controller: dateOfBirthController,
                      style: const TextStyle(color: grayWhite),
                      readOnly: true,
                      decoration: const InputDecoration(
                        labelText: "Date of Birth",
                        labelStyle: TextStyle(color: grayWhite),
                        prefixIcon: Icon(
                          Icons.calendar_today,
                          color: grayWhite,
                        ),
                        border: OutlineInputBorder(),
                        fillColor: lightBlack,
                        filled: true,
                        hintStyle: TextStyle(color: grayWhite),
                      ),
                      onTap: () async {
                        DateTime? newDate = await showDatePicker(
                          context: context,
                          initialDate: dob,
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                        );

                        if (newDate != null) {
                          // format date in required form here we use yyyy-MM-dd that means time is removed
                          String normalFormatDate =
                              DateFormat('yyyy-MM-dd').format(newDate);

                          setState(() {
                            //set foratted date to TextField value.
                            dateOfBirthController.text = normalFormatDate;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 15),

                    // Phone Number
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      decoration: BoxDecoration(
                          color: lightBlack,
                          border: Border.all(
                              color: Colors.black.withOpacity(0.13))),
                      child: Stack(
                        children: [
                          InternationalPhoneNumberInput(
                            onInputChanged: (PhoneNumber number) {
                              combinedPhone = number.phoneNumber.toString();
                            },
                            selectorTextStyle:
                                const TextStyle(color: mainWhite),
                            cursorColor: mainWhite,
                            formatInput: false,
                            selectorConfig: const SelectorConfig(
                              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                            ),
                            initialValue: number,
                            textFieldController: phoneNumberController,
                            inputDecoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.only(bottom: 15, left: 0),
                              border: InputBorder.none,
                              hintText: 'Phone Number',
                              hintStyle: TextStyle(
                                color: mainWhite,
                                fontSize: 16,
                              ),
                            ),
                            textStyle: TextStyle(color: mainWhite),
                          ),
                          Positioned(
                            left: 90,
                            top: 8,
                            bottom: 8,
                            child: Container(
                              height: 40,
                              width: 1,
                              color: Colors.white.withOpacity(0.5),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),

                    // gender
                    DropdownButtonFormField(
                      value: _selectedVal,
                      items: _genderList
                          .map(
                              (e) => DropdownMenuItem(child: Text(e), value: e))
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
                      dropdownColor: Colors.grey,
                      decoration: const InputDecoration(
                          label: Text('Gender',
                              style: TextStyle(color: Colors.white)),
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
                ),
              ),
              const SizedBox(height: 30),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : MainButtomWidget(
                      active: checkImage(),
                      btnText: 'Continue',
                      textSize: 16,
                      press: () {
                        if (dateOfBirthController.text == '') {
                          print('#################### 1');
                          Get.snackbar(
                            'Attention Please!',
                            'Enter you Date of Birth to continue',
                            snackPosition: SnackPosition.TOP,
                            duration: const Duration(seconds: 5),
                            colorText: mainWhite,
                          );
                        } else if (usernameController.text == '') {
                          print('#################### 2');
                          Get.snackbar(
                            'Attention Please!',
                            'Enter you a Username to continue',
                            snackPosition: SnackPosition.TOP,
                            duration: const Duration(seconds: 5),
                            colorText: mainWhite,
                          );
                        } else {
                          print('#################### 3');
                          print(doesUserExist(usernameController.text));
                          print('#################### 3.5');

                          if (doesUserExist(usernameController.text) == true) {
                            print('#################### 4');
                            print(
                                doesUserExist(usernameController.text).noUser);
                            Get.snackbar(
                              'User Already Taken!',
                              'Username already in use by another person! Choose another username',
                              snackPosition: SnackPosition.TOP,
                              duration: const Duration(seconds: 5),
                              colorText: mainWhite,
                            );
                          } else {
                            print('#################### 5');

                            setState(() {
                              isLoading = true;
                            });
                            authController.updateProfile(
                              usernameController.text,
                              emailController.text,
                              fullnameController.text,
                              DateTime.parse(dateOfBirthController.text),
                              combinedPhone,
                              _selectedVal,
                              profileImageUrl,
                            );
                          }
                        }
                      },
                    ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
