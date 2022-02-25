import 'package:attendance_app/login_screen.dart';
import 'package:attendance_app/register_employee.dart';
import 'package:attendance_app/tempscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyBM3QEYhtIzcLa5ZnqsTJM73L5qO49sBm4',
        appId: '1:544405368589:web:ab9bedd2197d1a1ae54a44',
        messagingSenderId: '544405368589',
        projectId: 'attendence-907f8',
        storageBucket: "attendence-907f8.appspot.com",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const InitialApp());
}

class InitialApp extends StatelessWidget {
  const InitialApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      getPages: [
        GetPage(
            name: '/',
            page: () => const RegisterEmployeeScreen(uid: '', email: '')),
      ],
    );
  }
}

class InitialClass extends StatefulWidget {
  const InitialClass({Key? key}) : super(key: key);

  @override
  _InitialClassState createState() => _InitialClassState();
}

class _InitialClassState extends State<InitialClass> {
  late FirebaseAuth auth;
  late bool isUserChecked;
  late bool isUserLoggedIn;

  late FirebaseFirestore _firestore;

  @override
  void initState() {
    auth = FirebaseAuth.instance;
    _firestore = FirebaseFirestore.instance;
    // TODO: implement initState
    super.initState();
  }

  void isUserLoggedIN(String userID, String email, BuildContext context) async {
    await _firestore.collection("Businesses").doc(userID).get().then((value) {
      Get.to(
        () => RegisterEmployeeScreen(
          uid: userID,
          email: email.toString(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: auth.authStateChanges(),
      builder: (ctx, userSnapshot) {
        if (userSnapshot.hasData) {
          isUserLoggedIN(auth.currentUser!.uid.toString(),
              auth.currentUser!.email.toString(), context);
          return const Scaffold(
            backgroundColor: Color(0xFFFFCC00),
            body: Center(
                child: SizedBox(
              width: 60.0,
              height: 60.0,
              child: CircularProgressIndicator(
                strokeWidth: 5.0,
                color: Colors.white,
              ),
            )),
          );
        } else if (userSnapshot.hasError) {
          return const CircularProgressIndicator(
            color: Colors.white,
          );
        }
        return const LoginScreen();
      },
    );
  }
}
