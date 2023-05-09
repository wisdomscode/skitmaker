import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:skitmaker/constants/colors.dart';
import 'package:skitmaker/constants/constance.dart';
import 'package:skitmaker/views/widgets/go_back_button.dart';
import 'package:skitmaker/views/widgets/large_text.dart';
import 'package:skitmaker/views/widgets/primary_button_widget.dart';

class UpdateBioData extends StatefulWidget {
  const UpdateBioData({super.key});

  @override
  State<UpdateBioData> createState() => _UpdateBioDataState();
}

class _UpdateBioDataState extends State<UpdateBioData> {
  final args = Get.arguments;
  var formKey = GlobalKey<FormState>();

  final docUid = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final fullnameController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final phoneNumberController = TextEditingController();

  @override
  void initState() {
    docUid.value = TextEditingValue(text: args[0]['uid']);
    usernameController.value = TextEditingValue(text: args[1]['username']);
    emailController.value = TextEditingValue(text: args[2]['email']);
    fullnameController.value = TextEditingValue(text: args[3]['fullName']);

    // date of birth
    var originDOB = args[4]['dob'];
    var formattedDate = DateFormat("yyyy-MM-dd").format(
      DateTime.parse(originDOB.toDate().toString()),
    );
    dateOfBirthController.value = TextEditingValue(text: formattedDate);

    // get phone number without dialCode
    var fullPhonNo = args[5]['phoneNumber'];
    if (fullPhonNo != '') {
      phoneNumPart = fullPhonNo.substring(4);
    }
    phoneNumberController.value =
        TextEditingValue(text: fullPhonNo != '' ? phoneNumPart : fullPhonNo);

    newGender = args[6]['gender'];
    profileImageUrl = args[7]['profileImage'];
  }

  DateTime? dob = DateTime.now();

  // Phone number setting
  String initialCountry = 'NG';
  PhoneNumber number = PhoneNumber(isoCode: 'NG');

  void getPhoneNumber(String phoneNumber) async {
    PhoneNumber number =
        await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'NG');

    setState(() {
      this.number = number;
    });
  }

  var dialCode = '';
  var dialCodeLength = 0;
  var combinedPhone = '';
  var phoneNumPart = '';
  var profileImageUrl = '';

  @override
  void dispose() {
    phoneNumberController.dispose();
    super.dispose();
  }

  // end of phone number setting
  var newGender = '';
  final _genderList = ['Male', 'Female'];

  String? _selectedVal = 'Male';
  bool isLoading = false;

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
                      text: 'Update Bio Data',
                      textSize: 18,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Form(
                key: formKey,
                child: Column(
                  children: [
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
                    const SizedBox(height: 25),

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
                          initialDate: dob!,
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
                    const SizedBox(height: 25),

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
                              // discoupling number to get the various details
                              combinedPhone = number.phoneNumber.toString();
                              dialCode = number.dialCode.toString();
                              dialCodeLength = dialCode.length;
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
                              hintStyle:
                                  TextStyle(color: mainWhite, fontSize: 16),
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
                    const SizedBox(height: 25),

                    // gender
                    DropdownButtonFormField(
                      value: newGender == '' ? _selectedVal : newGender,
                      items: _genderList
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              ))
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
                      // focusColor: lightBlack,
                      decoration: const InputDecoration(
                          label: Text(
                            'Gender',
                            style: TextStyle(color: Colors.white),
                          ),
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
                      active: true,
                      btnText: 'Continue',
                      textSize: 16,
                      press: () {
                        authController.updateProfile(
                          usernameController.text,
                          emailController.text,
                          fullnameController.text,
                          DateTime.parse(dateOfBirthController.text),
                          combinedPhone,
                          _selectedVal,
                          profileImageUrl,
                        );
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
