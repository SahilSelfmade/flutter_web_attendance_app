import 'package:attendance_app/home_page.dart';
import 'package:attendance_app/screens/crud/business_detail_main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/text_field_input.dart';

class BusinessDetailsPage extends StatefulWidget {
  const BusinessDetailsPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  final String id;

  @override
  State<BusinessDetailsPage> createState() => _BusinessDetailsPageState();
}

class _BusinessDetailsPageState extends State<BusinessDetailsPage> {
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
                            'Registered Business Details',
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
                          enabled: false,
                          labelText: 'address',
                          textInputType: TextInputType.text,
                          onChanged: (value) => address = value,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        TextFieldInput(
                          textEditingController: _clockinemployee,
                          enabled: false,
                          labelText: 'clockin_employee',
                          textInputType: TextInputType.text,
                          onChanged: (value) => clockinEmployee = value,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        TextFieldInput(
                          enabled: false,
                          labelText: 'company_name',
                          textEditingController: _companyname,
                          textInputType: TextInputType.text,
                          onChanged: (value) => companyName = value,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        TextFieldInput(
                          enabled: false,
                          labelText: 'owner_name',
                          textEditingController: _ownername,
                          textInputType: TextInputType.text,
                          onChanged: (value) => ownerName = value,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        TextFieldInput(
                          enabled: false,
                          labelText: 'owner_phone',
                          textEditingController: _ownerphone,
                          textInputType: TextInputType.text,
                          onChanged: (value) => ownerPhone = value,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        TextFieldInput(
                          enabled: false,
                          labelText: 'subscription_expiry',
                          textEditingController: _subscriptionexpiry,
                          textInputType: TextInputType.text,
                          onChanged: (value) => subscriptionExpiry = value,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        TextFieldInput(
                          enabled: false,
                          labelText: 'total_employees',
                          textEditingController: _totalemployee,
                          textInputType: TextInputType.text,
                          onChanged: (value) => totalEmployees = value,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        TextFieldInput(
                          enabled: false,
                          labelText: 'total_office_loc',
                          textEditingController: _totalofficelocation,
                          textInputType: TextInputType.text,
                          onChanged: (value) => totalOfficeLoc = value,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        TextFieldInput(
                          enabled: false,
                          labelText: 'zip',
                          textEditingController: _zip,
                          textInputType: TextInputType.text,
                          onChanged: (value) => zip = value,
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
