import 'dart:ui';

import 'package:attendance_app/main.dart';
import 'package:attendance_app/tempscreen.dart';
import 'package:attendance_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'resources/auth_methods.dart';
import 'widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);
    if (res == 'success') {
      Get.offAll(() => const InitialClass());
      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      Get.snackbar(
        'Login Failed',
        'please try again',
        isDismissible: true,
        duration: const Duration(
          seconds: 2,
        ),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 32.0,
            ),
            width: MediaQuery.of(context).size.width * 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: Container(),
                  flex: 2,
                ),
                Text(
                  'Logo\nArea',
                  style: GoogleFonts.oswald(
                    textStyle: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 64,
                ),
                // EMAIL FIELD
                TextFieldInput(
                  hintText: 'E-Mail',
                  textInputType: TextInputType.emailAddress,
                  textEditingController: _emailController,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFieldInput(
                  hintText: 'Password',
                  isPass: true,
                  textInputType: TextInputType.text,
                  textEditingController: _passwordController,
                ),
                const SizedBox(
                  height: 24,
                ),
                // LOGIN Button
                InkWell(
                  onTap: loginUser,
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
                    child: const Text(
                      'LOGIN',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
