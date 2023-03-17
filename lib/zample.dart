// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:skitmaker/constants/constance.dart';
// import 'package:intl_phone_number_input/intl_phone_number_input.dart';
// import 'package:intl/intl.dart';

// import 'package:flutter/material.dart';
// import 'package:skitmaker/views/widgets/dialog_box_widget.dart';
// import 'package:skitmaker/views/widgets/go_back_button.dart';
// import 'package:skitmaker/views/widgets/large_text.dart';

// import 'package:skitmaker/constants/colors.dart';
// import 'package:skitmaker/views/widgets/primary_button_widget.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:skitmaker/models/user_model.dart' as user_model;

// bool smsSelected = false;
// bool emailSelected = false;

// class UserProfilePage extends StatefulWidget {
//   UserProfilePage({super.key, this.user});

//   user_model.User? user;
//   @override
//   State<UserProfilePage> createState() => _UserProfilePageState();
// }

// class _UserProfilePageState extends State<UserProfilePage> {

//   // get the user detail to update
//     Future<user_model.User?> readUser() async {
//     // Get single document by ID
//     final docUser = firestore.collection('users').doc(firebaseAuth.currentUser!.uid);
//     final snapshot = await docUser.get();

//     final user = user_model.User.fromJson(snapshot.data()!);

//     return user;

//     // if (snapshot.exists) {
//     //   return user_model.User.fromJson(snapshot.data()!);
//     // } else {
//     //   return null;
//     // }

//     // update specific field and nexted value
//     // docUser.update({
//     //   'fullName':'Obi Johnson',
//     //   'phoneNumber': '+234543455',
//     //   'city.name':'Sydney',
//     //   'city.country':'Australia',
//     // });

//     // delete a field
//     // docUser.update({
//     //   'phoneNumber': FieldValue.delete(),
//     //   'city.country': FieldValue.delete(),
//     // });

//     // delete a document
//     // docUser.delete();
//   }

//   /// image Variable
//   File? imageFile;
//   String profileImageUrl = '';

//   // 1. Pick image:
//   // install image_picker
//   // import the corresponding library
//   ImagePicker imagePicker = ImagePicker();

//   pickImage(ImageSource source) async {
//     final XFile? image = await imagePicker.pickImage(source: source);
//     print('${image?.path}');

//     // code to display selected image on UI and close select button
//     if (image != null) {
//       imageFile = File(image.path);
//       setState(() {

//       });
//       Get.back();
//     }

//     if(image == null) return;
//     // 2. Upload to firebase storage
//     // install firebase_storage
//     // import the library

//     // Create a referecnce to storage root
//     Reference referenceRoot = FirebaseStorage.instance.ref();

//     // Create referenceFolder
//     Reference referenceDirImage = referenceRoot.child('profileImages');

//     // Create a reference for the image to be stored
//     // you can pass a child the image name as
//     // string ("image_name")
//     // local file ("${image?.path}")
//     // or create a unique name using DateTime stamp
//     // or use the user uid as in this case

//     String fileName = image.name;
//     String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
//     String userUid = firebaseAuth.currentUser!.uid;  // get currentUser id

//     Reference referenceImageToUpload =  referenceDirImage.child(userUid);

//     // Handle upload errors/success
//     try {
//       // Store the file
//       await referenceImageToUpload.putFile(File(image.path));

//       // Success: get the downlaod URL
//       profileImageUrl = await referenceImageToUpload.getDownloadURL();
//       print(profileImageUrl);
//     } catch(e) {
//       // Some error occured
//     }

//   }

//   var formKey = GlobalKey<FormState>();
//   final usernameController = TextEditingController();
//   final emailController = TextEditingController();
//   final fullnameController = TextEditingController();
//   final dateOfBirthController = TextEditingController();
//   final phoneNumberController = TextEditingController();

//   final docUid = TextEditingController();

//   String initialCountry = 'NG';
//   PhoneNumber number = PhoneNumber(isoCode: 'NG');

//   void getPhoneNumber(String phoneNumber) async {
//     PhoneNumber number =
//         await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'NG');

//     setState(() {
//       this.number = number;
//     });
//   }
//   var combinedPhone = '';

//   @override
//   void dispose() {
//     phoneNumberController.dispose();
//     super.dispose();
//   }

//   _UserProfilePageState() {
//     _selectedVal = _genderList[0];
//   //  dateFormat;
//   }

//   final _genderList = ['Male', 'Female', "Others"];
//   String? _selectedVal = '';

//   // Date picker
//   DateTime dob = DateTime.now();

//   @override
//   void initState() {
//     docUid.value = TextEditingValue(text: widget.user!.uid.toString());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: mainBlack,
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 30),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 40),
// Row(
//   children: [
//     const GoBackButtonWidget(),
//     const SizedBox(width: 20),
//     Center(
//       child: LargeTextWidget(
//         text: 'Update Your Profile',
//         textSize: 20,
//       ),
//     ),
//   ],
// ),
//               ),
//               const SizedBox(height: 20),
//               Container(
//                 child: Form(
//                   key: formKey,
//                   child: Column(
//                     children: [
//                       Stack(
//                         children: [
//                           Container(
//                             width: 120,
//                             height: 120,
//                             decoration: BoxDecoration(
//                               image: imageFile == null
//                                   ? const DecorationImage(
//                                       image: AssetImage("images/profiles/profile-2.png"),
//                                       fit: BoxFit.fill)
//                                   : DecorationImage(
//                                       image: FileImage(imageFile!),
//                                       fit: BoxFit.fill),
//                               color: mainBlack,
//                               shape: BoxShape.circle,
//                               border: Border.all(width:5, color: lightBlack),
//                             ),
//                           ),
//                           Positioned(
//                             bottom: -10,
//                             right: -5,
//                             child: DialogBoxWidget(
//                               title: 'Upload Photo',
//                               content: 'Choose Image Source',
//                               openDialogMessage: const Icon(Icons.add_a_photo),
//                               firstActionWidget: ElevatedButton.icon(
//                                 icon: const Icon(Icons.image_outlined),
//                                 label: const Text('From Gallery'),
//                                 onPressed: () => pickImage(ImageSource.gallery),
//                               ),
//                               secondActionWidget: ElevatedButton.icon(
//                                 icon: const Icon(Icons.camera_alt_outlined),
//                                 label: const Text('From Camera'),
//                                 onPressed: () => pickImage(ImageSource.camera),
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                       const SizedBox(height: 20),
// Uid
// TextFormField(
//   controller: docUid,
//   readOnly: true,
//   autofocus: false,
//   style: const TextStyle(color: grayWhite),
//   decoration: const InputDecoration(
//     label: Text(
//       'User ID',
//       style: TextStyle(color: grayWhite),
//     ),
//     prefixIcon: Icon(
//       Icons.star,
//       color: grayWhite,
//     ),
//     border: OutlineInputBorder(),
//     fillColor: lightBlack,
//     filled: true,
//     hintStyle: TextStyle(color: grayWhite),
//   ),
// ),
// const SizedBox(height: 15),
//                       // Username
//                       TextFormField(
//                         controller: usernameController,
//                         keyboardType: TextInputType.text,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                               return 'Username CANNOT be empty';
//                           }
//                           return null;
//                         },
//                         style: const TextStyle(color: grayWhite),
//                         decoration: const InputDecoration(
//                           label: Text(
//                             'Username',
//                             style: TextStyle(color: grayWhite),
//                           ),
//                           prefixIcon: Icon(
//                             Icons.star,
//                             color: grayWhite,
//                           ),
//                           border: OutlineInputBorder(),
//                           fillColor: lightBlack,
//                           filled: true,
//                           hintStyle: TextStyle(color: grayWhite),
//                         ),
//                       ),
//                       const SizedBox(height: 15),
//                       // email
//                       TextFormField(
//                         controller: emailController,
//                         // readOnly: true,
//                         style: const TextStyle(color: grayWhite),
//                         decoration: const InputDecoration(
//                           label: Text(
//                             'Email',
//                             style: TextStyle(color: grayWhite),
//                           ),
//                           prefixIcon: Icon(
//                             Icons.email,
//                             color: grayWhite,
//                           ),
//                           border: OutlineInputBorder(),
//                           fillColor: lightBlack,
//                           filled: true,
//                           hintStyle: TextStyle(color: grayWhite),
//                         ),
//                       ),
//                       const SizedBox(height: 15),

//                       // Name
//                       TextFormField(
//                         controller: fullnameController,
//                         validator: (value) =>
//                             value == "" ? "Please enter your name" : null,
//                         style: const TextStyle(color: grayWhite),
//                         decoration: const InputDecoration(
//                           label: Text(
//                             'Full Name',
//                             style: TextStyle(color: grayWhite),
//                           ),
//                           prefixIcon: Icon(
//                             Icons.person,
//                             color: grayWhite,
//                           ),
//                           border: OutlineInputBorder(),
//                           fillColor: lightBlack,
//                           filled: true,
//                           hintStyle: TextStyle(color: grayWhite),
//                         ),
//                       ),
//                       const SizedBox(height: 15),

//                       // date of birth
//                       TextFormField(
//                         controller: dateOfBirthController,
//                         style: const TextStyle(color: grayWhite),
//                         readOnly: true,
//                         decoration:  const InputDecoration(
//                           labelText: "Date of Birth",
//                           labelStyle: TextStyle(color: grayWhite),
//                           prefixIcon: Icon(
//                             Icons.calendar_today,
//                             color: grayWhite,
//                           ),
//                           border: OutlineInputBorder(),
//                           fillColor: lightBlack,
//                           filled: true,
//                           hintStyle: TextStyle(color: grayWhite),
//                         ),
//                         onTap: () async {
//                           DateTime? newDate = await showDatePicker(
//                             context: context,
//                             initialDate: dob,
//                             firstDate: DateTime(1900),
//                             lastDate: DateTime(2100),
//                           );

//                           if(newDate != null) {
//                             // format date in required form here we use yyyy-MM-dd that means time is removed
//                             String normalFormatDate = DateFormat('yyyy-MM-dd').format(newDate);

//                             setState(() {
//                                //set foratted date to TextField value.
//                               dateOfBirthController.text = normalFormatDate;

//                             });
//                           }
//                         },
//                       ),
//                       const SizedBox(height: 15),

//                       // Phone Number
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 15, vertical: 5),
//                         decoration: BoxDecoration(
//                             color: lightBlack,
//                             border: Border.all(
//                                 color: Colors.black.withOpacity(0.13))),
//                         child: Stack(
//                           children: [
//                             InternationalPhoneNumberInput(
//                               onInputChanged: (PhoneNumber number) {
//                                 combinedPhone = number.phoneNumber.toString();

//                               },
//                               selectorTextStyle:
//                                   const TextStyle(color: mainWhite),
//                               cursorColor: mainWhite,
//                               formatInput: false,
//                               selectorConfig: const SelectorConfig(
//                                 selectorType:
//                                     PhoneInputSelectorType.BOTTOM_SHEET,
//                               ),
//                               initialValue: number,
//                               textFieldController: phoneNumberController,
//                               inputDecoration: const InputDecoration(
//                                 contentPadding:
//                                     EdgeInsets.only(bottom: 15, left: 0),
//                                 border: InputBorder.none,
//                                 hintText: 'Phone Number',
//                                 hintStyle: TextStyle(
//                                   color: mainWhite,
//                                   fontSize: 16,
//                                 ),

//                               ),
//                               textStyle: TextStyle(color: mainWhite),
//                             ),
//                             Positioned(
//                               left: 90,
//                               top: 8,
//                               bottom: 8,
//                               child: Container(
//                                 height: 40,
//                                 width: 1,
//                                 color: Colors.white.withOpacity(0.5),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                       const SizedBox(height: 15),

//                       // gender
//                       DropdownButtonFormField(
//                         value: _selectedVal,
//                         items: _genderList
//                             .map((e) =>
//                                 DropdownMenuItem(child: Text(e), value: e))
//                             .toList(),
//                         onChanged: (val) {
//                           setState(() {
//                             _selectedVal = val as String;
//                           });
//                         },
//                         style: const TextStyle(color: mainWhite),
//                         icon: const Icon(
//                           Icons.arrow_drop_down_circle,
//                           color: mainWhite,
//                         ),
//                         dropdownColor: lightBlack,
//                         decoration: const InputDecoration(
//                             label: Text('Gender', style: TextStyle(color: Colors.white)),
//                             prefixIcon: Icon(
//                               Icons.accessibility_new_rounded,
//                               color: mainWhite,
//                             ),
//                             border: OutlineInputBorder(),
//                             fillColor: lightBlack,
//                             filled: true,
//                             hintStyle: TextStyle(color: mainWhite)),
//                       ),

//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 30),
//               MainButtomWidget(
//                 btnText: 'Continue',
//                 textSize: 16,
//                 press: () {
//                   // update profile first

//                   authController.updateProfile(
//                     usernameController.text,
//                     emailController.text,
//                     fullnameController.text,
//                     DateTime.parse(dateOfBirthController.text),
//                     combinedPhone,
//                     _selectedVal,
//                     profileImageUrl,
//                   );

//                 },
//               ),
//               const SizedBox(height: 40),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

// FutureBuilder<user_model.User?>(
//               future: readUser(),
//               builder: (context, snapshot) {
//                 if (snapshot.hasData) {
//                   final user = snapshot.data;
//                   return user == null
//                       ? Padding(
//                           padding: const EdgeInsets.only(right: 15),
//                           child: IconButton(
//                             onPressed: () {
//                               Get.to(() => ProfilePage(),
//                                   transition: Transition.leftToRightWithFade,
//                                   duration: Duration(
//                                     seconds: 1,
//                                   ));
//                             },
//                             icon: const CircleAvatar(
//                               backgroundImage:
//                                   AssetImage('images/profiles/profile-2.png'),
//                             ),
//                           ),
//                         )
//                       : Padding(
//                           padding: const EdgeInsets.only(right: 15),
//                           child: IconButton(
//                             onPressed: () {
//                               Get.to(
//                                 () => ProfilePage(),
//                                 transition: Transition.leftToRightWithFade,
//                                 duration: Duration(
//                                   seconds: 1,
//                                 ),
//                               );
//                             },
//                             icon: CircleAvatar(
//                               backgroundImage: NetworkImage(user.profileImage!),
//                             ),
//                           ),
//                         );
//                 } else {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }
//               },
//             ),

// Future<user_model.User?> readUser() async {
//   // Get single document by ID
//   final docUser =
//       firestore.collection('users').doc(firebaseAuth.currentUser!.uid);
//   final snapshot = await docUser.get();

//   return user_model.User.fromJson(snapshot.data()!);
// }
// }

//////////////////////////////////////////
/// QUICKY WIDGET
// SingleChildScrollView(
//         child: Obx(() {
//           return PageView.builder(
//             itemCount: skitController.skitList.length,
//             controller: PageController(initialPage: 0, viewportFraction: 1),
//             scrollDirection: Axis.vertical,
//             itemBuilder: (context, index) {
//               final data = skitController.skitList[index];
//               return Stack(
//                 alignment: Alignment.bottomCenter,
//                 children: [
//                   VideoPlayerItem(
//                     skitUrl: data.skitUrl,
//                   ),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Expanded(
//                         flex: 3,
//                         child: Container(
//                           padding: const EdgeInsets.only(left: 20, bottom: 20),
//                           decoration:
//                               const BoxDecoration(color: Colors.transparent),
//                           height: MediaQuery.of(context).size.height / 4,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               Text(data.username,
//                                   style: const TextStyle(
//                                       fontWeight: FontWeight.w900,
//                                       color: mainWhite)),
//                               const SizedBox(height: 10),
//                               ExpandableText(
//                                 data.description,
//                                 expandText: 'See more',
//                                 collapseText: '  ...Less',
//                                 expandOnTextTap: true,
//                                 collapseOnTextTap: true,
//                                 maxLines: 2,
//                                 linkColor: mainWhite,
//                                 style: const TextStyle(color: grayWhite),
//                               ),
//                               const SizedBox(height: 10),
//                               Row(
//                                 children: [
//                                   const Icon(
//                                     Icons.music_note,
//                                     size: 18.0,
//                                     color: mainWhite,
//                                   ),
//                                   const SizedBox(width: 8),
//                                   SizedBox(
//                                     height: 20,
//                                     width:
//                                         MediaQuery.of(context).size.width / 2,
//                                     child: Marquee(
//                                       text: data.skitTitle,
//                                       velocity: 10,
//                                       style: const TextStyle(
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.w700,
//                                           color: mainWhite),
//                                     ),
//                                   )
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         child: SizedBox(
//                             height: MediaQuery.of(context).size.height / 1.75,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               crossAxisAlignment: CrossAxisAlignment.end,
//                               children: [
//                                 _profileImageButton(data.profileImage),
//                                 const SizedBox(height: 5),
//                                 _sideBarItem(
//                                   Icons.favorite,
//                                   data.likes.length.toString(),
//                                   const TextStyle(
//                                     color: mainWhite,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                   () {
//                                     print('Like pressed');
//                                   },
//                                 ),
//                                 _sideBarItem(
//                                   Icons.chat_rounded,
//                                   data.commentCount.toString(),
//                                   const TextStyle(
//                                       color: mainWhite,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 10),
//                                   () {},
//                                 ),
//                                 _sideBarItem(
//                                   Icons.share,
//                                   data.shareCount.toString(),
//                                   const TextStyle(
//                                     color: mainWhite,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                   () {},
//                                 ),
//                                 _sideBarItem(
//                                   Icons.folder_special,
//                                   'My List',
//                                   const TextStyle(
//                                     color: mainWhite,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                   () {},
//                                 ),
//                                 AnimatedBuilder(
//                                   animation: _animationController,
//                                   child: Stack(
//                                     alignment: Alignment.center,
//                                     children: [
//                                       SizedBox(
//                                         height: 50,
//                                         width: 50,
//                                         child: Image.asset("images/disc.png"),
//                                       ),
//                                       CircleAvatar(
//                                         radius: 12,
//                                         backgroundImage:
//                                             NetworkImage(data.profileImage),
//                                       )
//                                     ],
//                                   ),
//                                   builder: (context, child) {
//                                     return Transform.rotate(
//                                       angle: 2 *
//                                           3.142 *
//                                           _animationController.value,
//                                       child: child,
//                                     );
//                                   },
//                                 )
//                               ],
//                             )),
//                       ),
//                     ],
//                   )
//                 ],
//               );
//             },
//           );
//         }),
//       ),

//////////////////////////////////////////////////
///PROFILE PAGE
///import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:skitmaker/constants/colors.dart';
import 'package:skitmaker/constants/constance.dart';
import 'package:skitmaker/views/screens/auth/login_page.dart';
import 'package:skitmaker/views/screens/profile/profile_tabs/profiletab_1.dart';
import 'package:skitmaker/views/screens/profile/profile_tabs/profiletab_2.dart';
import 'package:skitmaker/views/screens/profile/profile_tabs/profiletab_3.dart';
import 'package:skitmaker/views/widgets/large_text.dart';
import 'package:skitmaker/views/widgets/normal_text.dart';
import 'package:skitmaker/views/widgets/primary_button_widget.dart';
import 'package:get/get.dart';
import 'package:skitmaker/models/user_model.dart' as user_model;
import 'package:transparent_image/transparent_image.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Welcome',
            style: TextStyle(color: mainBlack),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.chevron_left),
            color: mainBlack,
            onPressed: () {
              Get.back();
            },
          ),
          actions: [
            PopupMenuButton(
                // add icon, by default "3 dot" icon
                child: const Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Icon(
                    Icons.more_vert,
                    color: mainBlack,
                  ),
                ),
                itemBuilder: (context) {
                  return [
                    const PopupMenuItem<int>(
                      value: 0,
                      child: Text("Bookmark Skit"),
                    ),
                    const PopupMenuItem<int>(
                      value: 1,
                      child: Text("Update Profile"),
                    ),
                    const PopupMenuItem<int>(
                      value: 2,
                      child: Text("Logout"),
                    ),
                  ];
                },
                onSelected: (value) {
                  if (value == 0) {
                    print("My account menu is selected.");
                  } else if (value == 1) {
                    print("Settings menu is selected.");
                  } else if (value == 2) {
                    Get.to(
                      () => LoginPage(),
                      transition: Transition.zoom,
                      duration: Duration(seconds: 1),
                    );
                    print("Logout menu is selected.");
                  }
                }),
          ],
        ),
        backgroundColor: mainWhite,
        body: FutureBuilder<user_model.User?>(
          future: readUser(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong! ${snapshot.error}');
            } else if (snapshot.hasData) {
              final user = snapshot.data;

              return user == null
                  ? const Center(
                      child: Text('No User'),
                    )
                  : Column(
                      children: [
                        //profile photo
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            image: user.profileImage == null
                                ? const DecorationImage(
                                    image: AssetImage(
                                        "images/profiles/profile-2.png"),
                                    fit: BoxFit.fill)
                                : DecorationImage(
                                    image: NetworkImage(user.profileImage!),
                                    fit: BoxFit.fill),
                            color: mainBlack,
                            shape: BoxShape.circle,
                            border: Border.all(width: 5, color: grayWhite),
                          ),
                        ),

                        // username
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0, bottom: 15),
                          child: Text(
                            '@${user.username}',
                            style: const TextStyle(
                              color: mainBlack,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        // number of following, followers, likes
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: Column(
                                  children: [
                                    LargeTextWidget(
                                      text: '123',
                                      textColor: mainBlack,
                                      textSize: 20,
                                    ),
                                    NormalTextWidget(
                                      text: 'Following',
                                      textColor: darkGrey,
                                      textSize: 16,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    LargeTextWidget(
                                      text: '103',
                                      textColor: mainBlack,
                                      textSize: 20,
                                    ),
                                    NormalTextWidget(
                                      text: 'Followers',
                                      textColor: darkGrey,
                                      textSize: 16,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  children: [
                                    LargeTextWidget(
                                      text: '1123',
                                      textColor: mainBlack,
                                      textSize: 20,
                                    ),
                                    NormalTextWidget(
                                      text: 'Likes',
                                      textColor: darkGrey,
                                      textSize: 16,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),

                        const SizedBox(height: 15),
                        // button - profile, insta likes, bookmark
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: MainButtomWidget(
                            btnText: 'Follow',
                            press: () {
                              print('Button is enabled');
                            },
                            active: true,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.only(left: 25.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 100,
                                    child: Text(
                                      'Name:',
                                      style: TextStyle(
                                        color: mainBlack,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '${user.fullName}',
                                    style: const TextStyle(
                                      color: mainBlack,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 100,
                                    child: Text(
                                      'Email:',
                                      style: TextStyle(
                                        color: mainBlack,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '${user.email}',
                                    style: const TextStyle(
                                      color: mainBlack,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 100,
                                    child: Text(
                                      'Phone:',
                                      style: TextStyle(
                                        color: mainBlack,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '${user.phoneNumber}',
                                    style: const TextStyle(
                                      color: mainBlack,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 100,
                                    child: Text(
                                      'Gender:',
                                      style: TextStyle(
                                        color: mainBlack,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '${user.gender}',
                                    style: const TextStyle(
                                      color: mainBlack,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 100,
                                    child: Text(
                                      'DOB:',
                                      style: TextStyle(
                                        color: mainBlack,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    DateFormat("dd/MM/yyyy").format(
                                      DateTime.parse('${user.dob}'),
                                    ),
                                    style: const TextStyle(
                                      color: mainBlack,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),

                              // bio
                              const Center(
                                child: Text(
                                  'Biography',
                                  style: TextStyle(
                                      color: mainBlack,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: NormalTextWidget(
                                  text:
                                      'This is this account bio, In publishing and graphic design',
                                  textColor: darkGrey,
                                  textSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 15),

                        //default tab controller
                        const TabBar(
                          tabs: [
                            Tab(
                              icon: Icon(Icons.grid_3x3, color: mainBlack),
                            ),
                            Tab(
                              icon: Icon(Icons.favorite, color: mainBlack),
                            ),
                            Tab(
                              icon: Icon(Icons.lock_outline_rounded,
                                  color: mainBlack),
                            ),
                          ],
                        ),

                        const Expanded(
                          child: TabBarView(children: [
                            FirstTab(),
                            SecondTab(),
                            ThirdTab(),
                          ]),
                        ),
                      ],
                    );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Future<user_model.User?> readUser() async {
    // Get single document by ID
    final docUser =
        firestore.collection('users').doc(firebaseAuth.currentUser!.uid);
    final snapshot = await docUser.get();

    return user_model.User.fromSnap(snapshot);

    //   String myuid = '';
    //   String username = '';
    //   String email = '';
    //   String fullName = '';
    //   dynamic dob;
    //   String phoneNumber = '';
    //   String gender = '';
    //   String profileImage = '';

    //   myuid = firebaseAuth.currentUser!.uid; // get currentUser id
    //   DocumentSnapshot userDoc =
    //       await firestore.collection('users').doc(myuid).get();

    //   var uid = (userDoc.data()! as Map<String, dynamic>)['uid'];
    //   username = (userDoc.data()! as Map<String, dynamic>)['username'];
    //   email = (userDoc.data()! as Map<String, dynamic>)['email'];
    //   fullName = (userDoc.data()! as Map<String, dynamic>)['fullName'];
    //   dob = (userDoc.data()! as Map<String, dynamic>)['dob'];
    //   phoneNumber = (userDoc.data()! as Map<String, dynamic>)['phoneNumber'];
    //   gender = (userDoc.data()! as Map<String, dynamic>)['gender'];
    //   profileImage = (userDoc.data()! as Map<String, dynamic>)['profileImage'];

    //   DateTime dateFromFS =
    //       DateTime.parse(dob.toDate().toString()); // normal timestamp
    //   var normalDate =
    //       DateFormat('yyyy-MM-dd').format(dateFromFS); // timestamp to date

    //   List userdata = [
    //     uid,
    //     username,
    //     email,
    //     fullName,
    //     normalDate,
    //     phoneNumber,
    //     gender,
    //     profileImage
    //   ];
  }
}
