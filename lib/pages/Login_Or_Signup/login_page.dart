import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import '../../Api_Service.dart';
import '../../Custom_widget/custom_text_field.dart';
import '../Home/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String userName = ''; // Initialize userName

  Future<void> _handleLogin() async {
    final userName = userNameController.text;
    final password = passwordController.text;

    final apiResponse = await ApiService().fetchLoginData(userName, password);

    if (apiResponse['success']) {
      String token = apiResponse['token'];

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login successful!'),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.green,
        ),
      );

      // Save the userName
      this.userName = userName;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(token: token, userName: userName),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(apiResponse['message'] ?? 'Login failed. Please check your credentials.'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Lottie.asset(
            'lib/Images/login_page_animation.json',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          SingleChildScrollView(
            child: Container(
              height: screenHeight,
              color: Colors.transparent,
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: 0,),
                  Column(
                    children: [
                      Container(
                        height: 200,
                        width: 200,
                        child: Lottie.asset(
                          'lib/Images/animation_login.json',
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 50,),
                      CustomTextFields(
                        controller: userNameController,
                        labelText: 'User Name',
                        hintText: 'User Name',
                        disableOrEnable: true,
                        borderColor: 0xFFBCC2C2,
                        filled: false,
                        prefixIcon: Icons.account_circle,
                      ),
                      CustomTextFields(
                        controller: passwordController,
                        labelText: 'Password',
                        hintText: 'Password',
                        disableOrEnable: true,
                        borderColor: 0xFFBCC2C2,
                        filled: false,
                        prefixIcon: Icons.password_rounded,
                      ),
                      SizedBox(height: 30,),
                      Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: _handleLogin,
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                ),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.transparent),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      side: BorderSide(
                                        color: Colors.white,
                                        width: 3.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "I have no account...",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Handle navigation to the sign-up page here
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
