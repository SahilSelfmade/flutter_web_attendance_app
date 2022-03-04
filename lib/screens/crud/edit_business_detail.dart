import 'package:attendance_app/home_page.dart';
import 'package:attendance_app/home_screen.dart';
import 'package:attendance_app/screens/crud/business_detail_main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/text_field_input.dart';

class BusinessDetailsEditPage extends StatefulWidget {
  const BusinessDetailsEditPage({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  State<BusinessDetailsEditPage> createState() => _BusinessDetailsEditPageState();
}

class _BusinessDetailsEditPageState extends State<BusinessDetailsEditPage> {
  bool isLoading = false;
  CollectionReference owners =
      FirebaseFirestore.instance.collection('Businesses');

  final TextEditingController _address = TextEditingController();
  final TextEditingController _clockinemployee = TextEditingController();
  final TextEditingController _companyname = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _ownername = TextEditingController();
  final TextEditingController _ownerphone = TextEditingController();
  final TextEditingController _subscriptionexpiry = TextEditingController();
  final TextEditingController _totalemployee = TextEditingController();
  final TextEditingController _totalofficelocation = TextEditingController();
  final TextEditingController _zip = TextEditingController();

  Future<void> updateUser(
    id,
    address,
    clockinEmployee,
    companyName,
    ownerName,
    ownerPhone,
    subscriptionExpiry,
    totalEmployees,
    totalOfficeLoc,
    zip,
  ) {
    return owners
        .doc(id)
        .update({
          'address': address,
          'clockin_employee': clockinEmployee,
          'company_name': companyName,
          'owner_name': ownerName,
          'owner_phone': ownerPhone,
          'subscription_expiry': subscriptionExpiry,
          'total_employees': totalEmployees,
          'total_office_loc': totalOfficeLoc,
          'zip': zip,
        })
        .then(
          (value) => print("User Updated"),
        )
        .catchError(
          (onError) => print(onError),
        );
  }

  // Future<void> updateUser() {
  //   return Container();
  // }

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: true,
      body: Center(
        child: Container(
            color: Colors.white,
            width: screenW < 1000 ? screenW * 0.95 : screenW * 0.4,
            child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              future: FirebaseFirestore.instance
                  .collection('Businesses')
                  .doc(widget.id)
                  .get(),
              builder: (_, snapshot) {
                if (snapshot.hasError) {
                  print('Something went Wrong');
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var data = snapshot.data!.data();
                var address = data!['address'];
                var clockinEmployee = data['clockin_employee'];
                var companyName = data['company_name'];
                var ownerName = data['owner_name'];
                var ownerPhone = data['owner_phone'];
                var subscriptionExpiry = data['subscription_expiry'];
                var totalEmployees = data['total_employees'];
                var totalOfficeLoc = data['total_office_loc'];
                var zip = data['zip'];
                _address.text = address.toString();
                _clockinemployee.text = clockinEmployee.toString();
                _companyname.text = companyName.toString();
                _ownername.text = ownerName.toString();
                _ownerphone.text = ownerPhone.toString();
                _subscriptionexpiry.text = subscriptionExpiry.toString();
                _totalemployee.text = totalEmployees.toString();
                _totalofficelocation.text = totalOfficeLoc.toString();
                _zip.text = zip.toString();

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      children: [
                        const SizedBox(
                          height: 24,
                        ),
                        Center(
                          child: Text(
                            'Edit Register Business',
                            style: GoogleFonts.oswald(
                              textStyle: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 48,
                        ),
                        TextFieldInput(
                          textEditingController: _address,
                          labelText: 'address',
                          textInputType: TextInputType.text,
                          onChanged: (value) => address = value,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        TextFieldInput(
                          textEditingController: _clockinemployee,
                          labelText: 'clockin_employee',
                          textInputType: TextInputType.text,
                          onChanged: (value) => clockinEmployee = value,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        TextFieldInput(
                          labelText: 'company_name',
                          textEditingController: _companyname,
                          textInputType: TextInputType.text,
                          onChanged: (value) => companyName = value,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        TextFieldInput(
                          labelText: 'owner_name',
                          textEditingController: _ownername,
                          textInputType: TextInputType.text,
                          onChanged: (value) => ownerName = value,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        TextFieldInput(
                          labelText: 'owner_phone',
                          textEditingController: _ownerphone,
                          textInputType: TextInputType.text,
                          onChanged: (value) => ownerPhone = value,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        TextFieldInput(
                          labelText: 'subscription_expiry',
                          textEditingController: _subscriptionexpiry,
                          textInputType: TextInputType.text,
                          onChanged: (value) => subscriptionExpiry = value,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        TextFieldInput(
                          labelText: 'total_employees',
                          textEditingController: _totalemployee,
                          textInputType: TextInputType.text,
                          onChanged: (value) => totalEmployees = value,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        TextFieldInput(
                          labelText: 'total_office_loc',
                          textEditingController: _totalofficelocation,
                          textInputType: TextInputType.text,
                          onChanged: (value) => totalOfficeLoc = value,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        TextFieldInput(
                          labelText: 'zip',
                          textEditingController: _zip,
                          textInputType: TextInputType.text,
                          onChanged: (value) => zip = value,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        InkWell(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              updateUser(
                                widget.id,
                                address,
                                clockinEmployee,
                                companyName,
                                ownerName,
                                ownerPhone,
                                subscriptionExpiry,
                                totalOfficeLoc,
                                totalEmployees,
                                zip,
                              );
                              Get.off(const HomePage());
                              Get.snackbar(
                                'Success',
                                'Business Added Successfully.',
                                isDismissible: true,
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.5,
                                backgroundColor: Colors.white,
                                duration: const Duration(
                                  seconds: 2,
                                ),
                                snackPosition: SnackPosition.BOTTOM,
                              );
                              // Get.to
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
                              'Update'.toUpperCase(),
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
                        InkWell(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });

                              Get.off(const HomePage());
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
                              'Go Back'.toUpperCase(),
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
                );
              },
            )),
      ),
    );
  }
}
