import 'package:attendance_app/home_screen.dart';
import 'package:attendance_app/login_screen.dart';
import 'package:attendance_app/utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'main.dart';
import 'widgets/text_field_input.dart';

class RegisterEmployeeScreen extends StatefulWidget {
  const RegisterEmployeeScreen({
    Key? key,
    required this.uid,
    required this.email,
  }) : super(key: key);

  final String email;
  final String uid;

  @override
  State<RegisterEmployeeScreen> createState() => _RegisterEmployeeScreenState();
}

class _RegisterEmployeeScreenState extends State<RegisterEmployeeScreen> {
  bool isLoading = false;

  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _clockInEmployeeController =
      TextEditingController();

  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _ownerNameController = TextEditingController();
  final TextEditingController _ownerPhoneController = TextEditingController();
  final TextEditingController _subscriptionExpiryController =
      TextEditingController();

  final TextEditingController _totalEmployeeController =
      TextEditingController();

  final TextEditingController _totalOfficeLocationController =
      TextEditingController();

  // Firebase Collection Name
  final CollectionReference _user =
      FirebaseFirestore.instance.collection("Businesses");

  final TextEditingController _zipController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  registerEmployee(String? random) {
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
    }).then((value) {
      Get.off(
        () => const HomePageScreen(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      resizeToAvoidBottomInset: true,
      body: Center(
        child: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width * 0.5,
          padding: const EdgeInsets.symmetric(
            horizontal: 32.0,
          ),
          // width: MediaQuery.of(context).size.width * 0.8,
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 24,
              ),
              Center(
                child: Text(
                  'Register Business',
                  style: GoogleFonts.oswald(
                    textStyle: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                hintText: 'Address',
                textInputType: TextInputType.text,
                textEditingController: _addressController,
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                hintText: 'Clockin Employee',
                textInputType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
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
                textInputType: TextInputType.number,
                textEditingController: _ownerPhoneController,
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                hintText: 'Total Employees',
                textInputType: TextInputType.number,
                textEditingController: _totalEmployeeController,
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                hintText: 'Total Office Location',
                textInputType: TextInputType.number,
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
                      _subscriptionExpiryController.value.text != "" &&
                      _totalEmployeeController != "" &&
                      _totalOfficeLocationController != "" &&
                      _zipController != "") {
                    setState(() {
                      isLoading = true;
                    });
                    registerEmployee(null);
                    Get.snackbar(
                      'Success',
                      'Business Added Successfully.',
                      isDismissible: true,
                      maxWidth: MediaQuery.of(context).size.width * 0.5,
                      backgroundColor: Colors.white,
                      duration: const Duration(
                        seconds: 2,
                      ),
                      snackPosition: SnackPosition.BOTTOM,
                    );
                    // Get.to
                  } else {
                    Get.snackbar(
                      "Register Employee  Failed",
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
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: Text(
                    'Submit'.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
