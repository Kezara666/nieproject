import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nieproject/auth/authenticate_user.dart';
import 'package:nieproject/pages/player/player.dart';
import 'package:nieproject/utils/colors.dart';
import 'package:nieproject/widgets/hamburger.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  OnAirScreen onAirScreen = Get.find();
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(3, 20, 48, 1),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Navigation bar
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      // Go back logic
                      Get.to(() => onAirScreen);
                    },
                    icon: Icon(Icons.arrow_back),
                    color: Colors.white,
                  ),
                  Expanded(
                    child: Center(
                      child: Container(
                        width: screenWidth / 10,
                        height: screenHeight / 10,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/logo.png'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showPopupMenu(context);
                    },
                    icon: Icon(Icons.more_vert),
                    color: Colors.white,
                  ),
                ],
              ),

              Padding(
                padding: EdgeInsets.only(
                    top: screenHeight / 4,
                    left: screenWidth / 25,
                    right: screenWidth / 25),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: playAvatar),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: screenWidth / 15, top: screenWidth / 15),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Login to Continue ...",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(screenHeight / 60),
                        child: TextField(
                          style: TextStyle(color: Colors.white),
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
                            hintStyle: const TextStyle(color: Colors.white),
                            focusColor: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(screenHeight / 60),
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          controller: passwordController,
                          obscureText: !showPassword,
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
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  showPassword = !showPassword;
                                });
                              },
                              icon: Icon(
                                showPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
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
                            } catch (e) {
                              Fluttertoast.showToast(
                                msg: "Unable To Login ${e.toString()}",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.black.withOpacity(0.7),
                                textColor: Colors.white,
                              );
                            }

                            // Handle form submission here
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Color.fromARGB(255, 17, 28, 46),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(screenHeight / 60),
                            child: Text(
                              'Login',
                              style: GoogleFonts.montserrat(
                                color: const Color.fromARGB(255, 254, 253, 253),
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: screenWidth / 20, bottom: screenWidth / 20),
                        child: Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () {
                              Fluttertoast.showToast(
                                msg: "Visit the website to register.",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.black.withOpacity(0.7),
                                textColor: Colors.white,
                              );
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Register"),
                                    content:
                                        Text("Visit the website to register."),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("Close"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Text(
                              "Not Registered... Register",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> isTablet(double screenWidth, double screenHeight) async {
    // Check if the screen width is greater than or equal to 600 (adjust this threshold as needed)
    return screenWidth >= 600;
  }

  void showTabletErrorSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Tablets are not supported by this app.',
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
