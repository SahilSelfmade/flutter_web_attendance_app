import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login_screen.dart';
import 'resources/auth_methods.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class TempScreen extends StatefulWidget {
  final String? userID;

  const TempScreen({Key? key, this.userID}) : super(key: key);
  @override
  State<TempScreen> createState() => _TempScreenState();
}

class _TempScreenState extends State<TempScreen> {
  Future<void> signOut() async {
    await _auth.signOut();
    Get.offAll(() => LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.red,
        child: ElevatedButton(
          child: Text('signout'),
          onPressed: signOut,
        ),
      ),
    );
  }
}
