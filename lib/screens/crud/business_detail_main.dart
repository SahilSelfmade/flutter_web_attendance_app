import 'package:attendance_app/screens/crud/edit_business_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'business_detail_page.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class BusinessDetails extends StatefulWidget {
  const BusinessDetails({Key? key}) : super(key: key);

  @override
  State<BusinessDetails> createState() => _BusinessDetailsState();
}

class _BusinessDetailsState extends State<BusinessDetails> {
  CollectionReference owners =
      FirebaseFirestore.instance.collection('Businesses');

  final Stream<QuerySnapshot> ownersStream =
      FirebaseFirestore.instance.collection('Businesses').snapshots();

  Future<void> deleteUser(id) {
    return owners
        .doc(id)
        .delete()
        .then((value) => Get.snackbar(
              'User Deleted Successfully',
              ':disappointed:',
              isDismissible: true,
              maxWidth: MediaQuery.of(context).size.width * 0.5,
              duration: const Duration(
                seconds: 2,
              ),
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.white,
            ))
        .catchError((error) => Get.snackbar(
              'User Deleted Failed',
              '$error',
              isDismissible: true,
              maxWidth: MediaQuery.of(context).size.width * 0.5,
              duration: const Duration(
                seconds: 2,
              ),
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.white,
            ));
  }

  _bodyRowCell(List<dynamic> ownerDetails, int i, filedName) {
    return ListTile(
      title: Text(ownerDetails[i][filedName].toString()),
      tileColor: Colors.grey[100],
    );
  }

  _topRowCell(text) {
    return ListTile(
      title: Text(
        text.toUpperCase(),
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      tileColor: Colors.black,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: ownersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          print('Something Went Wrong');
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final List ownerDetails = [];

        snapshot.data!.docs.map((DocumentSnapshot document) {
          Map data = document.data() as Map<String, dynamic>;
          ownerDetails.add(data);
          data['id'] = document.id;
          print(document.id);
          print(data);
        }).toList();
        return Scaffold(
          backgroundColor: Colors.black,
          body: Scrollbar(
            scrollbarOrientation: ScrollbarOrientation.bottom,
            child: ListView(
              children: [
                const SizedBox(
                  height: 24,
                ),
                Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Table(
                      border: TableBorder.all(
                        color: Colors.grey,
                        style: BorderStyle.solid,
                        width: 2,
                      ),
                      defaultColumnWidth: const IntrinsicColumnWidth(),
                      // columnWidths: const <int, TableColumnWidth>{
                      //   2: FixedColumnWidth(100),

                      // },

                      children: [
                        TableRow(
                          children: [
                            // _topRowCell('Address'),
                            // _topRowCell('Clock In'),
                            _topRowCell('Company Name'),
                            _topRowCell('Owner Name'),
                            _topRowCell('Owner Phone'),
                            // _topRowCell('Subscription Expiry'),
                            // _topRowCell('Total Employee'),
                            // _topRowCell('Total Office Location'),
                            // _topRowCell('Zip'),
                            _topRowCell('Action'),
                          ],
                        ),
                        for (var i = 0; i < ownerDetails.length; i++) ...[
                          TableRow(
                            children: [
                              // _bodyRowCell(ownerDetails, i, 'address'),
                              // _bodyRowCell(ownerDetails, i, 'clockin_employee'),
                              _bodyRowCell(ownerDetails, i, 'company_name'),
                              _bodyRowCell(ownerDetails, i, 'owner_name'),
                              _bodyRowCell(ownerDetails, i, 'owner_phone'),
                              // _bodyRowCell(
                              //     ownerDetails, i, 'subscription_expiry'),
                              // _bodyRowCell(ownerDetails, i, 'total_employees'),
                              // _bodyRowCell(ownerDetails, i, 'total_office_loc'),
                              // _bodyRowCell(ownerDetails, i, 'zip'),
                              TableCell(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.remove_red_eye,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          Get.to(
                                            () => BusinessDetailsPage(
                                                id: ownerDetails[i]['id']),
                                          );
                                          print(ownerDetails);
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          Get.to(
                                            () => BusinessDetailsEditPage(
                                                id: ownerDetails[i]['id']),
                                          );
                                          print(ownerDetails);
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          deleteUser(ownerDetails[i]['id']);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ]
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
