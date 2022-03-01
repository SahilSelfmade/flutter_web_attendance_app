import 'package:attendance_app/home_screen.dart';
import 'package:attendance_app/main.dart';
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
      setState(() {
        _isLoading = false;
        Get.snackbar(
          'Login Successful',
          'Click on Add Business Button to Add a Business',
          isDismissible: true,
          maxWidth: MediaQuery.of(context).size.width * 0.5,
          duration: const Duration(
            seconds: 2,
          ),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
        );
      });
      Get.offAll(const HomePageScreen());
    } else if (_emailController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      setState(() {
        _isLoading = false;
      });
      Get.snackbar(
        'Login Failed',
        'All fields are Required.',
        isDismissible: true,
        maxWidth: MediaQuery.of(context).size.width * 0.5,
        backgroundColor: Colors.white,
        duration: const Duration(
          seconds: 2,
        ),
        snackPosition: SnackPosition.BOTTOM,
      );
    } else if (_passwordController.text.length < 6) {
      setState(() {
        _isLoading = false;
      });
      Get.snackbar(
        'Login Failed',
        'Password Length is too Short.',
        isDismissible: true,
        maxWidth: MediaQuery.of(context).size.width * 0.5,
        backgroundColor: Colors.white,
        duration: const Duration(
          seconds: 2,
        ),
        snackPosition: SnackPosition.BOTTOM,
      );
    } else if (_emailController.text.isEmail != true) {
      setState(() {
        _isLoading = false;
      });
      Get.snackbar(
        'Login Failed',
        'Please Enter a Valid E-Mail.',
        isDismissible: true,
        maxWidth: MediaQuery.of(context).size.width * 0.5,
        backgroundColor: Colors.white,
        duration: const Duration(
          seconds: 2,
        ),
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      setState(() {
        _isLoading = false;
      });
      Get.snackbar(
        'Login Failed',
        'Wrong Credentials',
        isDismissible: true,
        maxWidth: MediaQuery.of(context).size.width * 0.5,
        backgroundColor: Colors.white,
        duration: const Duration(
          seconds: 2,
        ),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 208, 208, 208),
      body: SafeArea(
        child: Center(
          child: Card(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 32.0,
              ),
              width: screenW < 1000 ? screenW * 0.95 : screenW * 0.4,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    'Logo Area',
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
                        color: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: const Text(
                        'LOGIN',
                        style: TextStyle(
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

                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
