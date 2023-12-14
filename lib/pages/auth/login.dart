import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nieproject/auth/authenticate_user.dart';
import 'package:nieproject/pages/chat/chat.dart';
import 'package:nieproject/pages/player/player.dart';
import 'package:nieproject/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:device_info/device_info.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  
  

  

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/a.gif'), // Replace with your image asset path
            fit: BoxFit.cover, // Adjust the fit property as needed
          ),
          gradient: linearGradient,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
              height: screenHeight / 2,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Text(
                      'NIE RADIO',
                      style: GoogleFonts.poppins(
                        color: Colors.white70,
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(screenHeight / 60),
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      controller: usernameController,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        labelStyle: GoogleFonts.aBeeZee(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                        filled: true,
                        fillColor: Colors.transparent,
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        // Set the text color to white
                        hintStyle: const TextStyle(
                            color: Colors.white), // Hint text color
                        focusColor: Colors
                            .white, // Color of the cursor and text when focused
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(screenHeight / 60),
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: GoogleFonts.aBeeZee(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                        filled: true,
                        fillColor: Colors.transparent,
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        hintStyle: const TextStyle(color: Colors.white),
                        focusColor: Colors.white,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      String username = usernameController.text;
                      String password = passwordController.text;

                      try {
                        bool isTabletDevice =
                            await isTablet(screenWidth, screenHeight);

                        if (isTabletDevice) {
                          showTabletErrorSnackBar(context);
                        } else {
                          login(username, password, context);
                          
                        }
                      } catch (e) {}

                      // Handle form submission here
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 58, 116, 216)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(40.0), // Set border radius
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(screenHeight / 60),
                      child: Text(
                        'Login',
                        style: GoogleFonts.aBeeZee(
                          color: const Color.fromARGB(255, 254, 253, 253),
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<bool> isTablet(double screenWidth, double screenHeight) async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    
    return screenWidth>= 600;

  }
  void showTabletErrorSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Tablets are not supported by this app.'),
      ),
    );
  }
}
