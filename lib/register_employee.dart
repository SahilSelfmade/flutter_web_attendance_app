import 'package:attendance_app/login_screen.dart';
import 'package:attendance_app/utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'main.dart';
import 'resources/auth_methods.dart';
import 'widgets/text_field_input.dart';

class RegisterEmployeeScreen extends StatefulWidget {
  final String email;
  final String uid;

  const RegisterEmployeeScreen({
    Key? key,
    required this.uid,
    required this.email,
  }) : super(key: key);

  @override
  State<RegisterEmployeeScreen> createState() => _RegisterEmployeeScreenState();
}

class _RegisterEmployeeScreenState extends State<RegisterEmployeeScreen> {
  final TextEditingController _ownerPhoneController = TextEditingController();
  final TextEditingController _totalEmployeeController =
      TextEditingController();
  final TextEditingController _totalOfficeLocationController =
      TextEditingController();
  final TextEditingController _zipController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _ownerNameController = TextEditingController();
  final TextEditingController _clockInEmployeeController =
      TextEditingController();
  final TextEditingController _subscriptionExpiryController =
      TextEditingController();
  bool isLoading = false;

  // Firebase Collection Name
  final CollectionReference _user =
      FirebaseFirestore.instance.collection("Businesses");

  @override
  void dispose() {
    super.dispose();
  }

  registerUser(String? random) {
    _user.doc(widget.uid).set({
      "address": _addressController.value.text,
      "clockin_employee": _clockInEmployeeController.value.text,
      "company_name": _companyNameController.value.text,
      "owner_name": _ownerNameController.value.text,
      "subscription_expiry": _subscriptionExpiryController.value.text,
      "owner_phone": _ownerPhoneController.value.text,
      "total_employees": _totalEmployeeController.value.text,
      "total_office_loc": _totalOfficeLocationController.value.text,
      "zip": _zipController.value.text,
      "email": widget.email,
    }).then((value) {
      Get.back();
      Get.off(() => const InitialClass());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 32.0,
            ),
            // width: MediaQuery.of(context).size.width * 0.8,
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: Container(),
                  flex: 2,
                ),
                // SVG Image

                const SizedBox(
                  height: 64,
                ),

                const SizedBox(
                  height: 24,
                ),
                TextFieldInput(
                  hintText: 'Address',
                  textInputType: TextInputType.emailAddress,
                  textEditingController: _addressController,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFieldInput(
                  hintText: 'Clockin Employee',
                  textInputType: TextInputType.text,
                  textEditingController: _clockInEmployeeController,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFieldInput(
                  hintText: 'Company Name',
                  textInputType: TextInputType.text,
                  textEditingController: _companyNameController,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFieldInput(
                  hintText: 'Owner Name',
                  textInputType: TextInputType.text,
                  textEditingController: _ownerNameController,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFieldInput(
                  hintText: 'Owner Phone',
                  textInputType: TextInputType.text,
                  textEditingController: _ownerPhoneController,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFieldInput(
                  hintText: 'Total Employees',
                  textInputType: TextInputType.text,
                  textEditingController: _totalEmployeeController,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFieldInput(
                  hintText: 'Total Office Location',
                  textInputType: TextInputType.text,
                  textEditingController: _totalOfficeLocationController,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFieldInput(
                  hintText: 'Zip',
                  textInputType: TextInputType.text,
                  textEditingController: _zipController,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFieldInput(
                  hintText: 'Subscription Expiry',
                  textInputType: TextInputType.text,
                  textEditingController: _subscriptionExpiryController,
                ),
                const SizedBox(
                  height: 24,
                ),

                InkWell(
                  onTap: () async {
                    if (_addressController.value.text != "" &&
                        _clockInEmployeeController.value.text != "" &&
                        _companyNameController.value.text != "" &&
                        _ownerNameController.value.text != "" &&
                        _subscriptionExpiryController.value.text != "") {
                      setState(() {
                        isLoading = true;
                      });
                      registerUser(null);
                    } else {
                      Get.snackbar(
                        "Signup Failed",
                        'All Fields are required.',
                        snackPosition: SnackPosition.BOTTOM,
                        isDismissible: true,
                        duration: const Duration(seconds: 2),
                        icon: const Icon(
                          Icons.dangerous,
                          color: Colors.red,
                        ),
                      );
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                    ),
                    decoration: ShapeDecoration(
                      color: blueColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: Text(
                      'Submit'.toUpperCase(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Flexible(
                  child: Container(),
                  flex: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: const Text('Already have an Account?'),
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.offAll(() => const LoginScreen());
                      },
                      child: Container(
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
