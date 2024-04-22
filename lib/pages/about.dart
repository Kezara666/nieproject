import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nieproject/pages/Menu/menu.dart';
import 'package:nieproject/widgets/hamburger.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  AboutPage _aboutPage = Get.find();
  final String longText = """
Immerse yourself in a world of knowledge. 
Whether you’re a student seeking understanding, 
a teacher desiring inspiration, or 
a lifelong learner chasing curiosity, 
AlphaU is your companion in the quest for 
educational excellence.  

AlphaU – where education meets the airwaves.

Advisor Board:
- Prasad Sethunaga (Director General)
- K. R. Pathmasiri (Deputy Director General)
- Chamila Edward (Senior Lecturer)

Chief System Architect:
Tharaka Leonardo Vipulaguna

Project Management:
Pradeep Ehan

Development Team:
- Kesara Dehipahawala 
- Ruwan Rathnayake
- Kusal Wijekoon
- Kasun Vichithra
- Umesha Madushani
- Hansi Tharushika
""";

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    MenuWindow menuWindow = Get.find();
    return Material(
      type: MaterialType.transparency,
      child: SafeArea(
        child: Container(
          decoration: const BoxDecoration(color: Color.fromRGBO(3, 20, 48, 1)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Nav bar
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Get.to(() => menuWindow);
                    },
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.white,
                  ),
                  Expanded(
                    child: Center(
                      child: Container(
                        width: screenWidth / 10,
                        height: screenHeight / 10,
                        // decoration: const BoxDecoration(
                        //   image: DecorationImage(
                        //     image: AssetImage('assets/logo.png'),
                        //   ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showPopupMenu(context);
                    },
                    icon: const Icon(Icons.more_vert),
                    color: Colors.white,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(),
                child: Container(
                  width: screenWidth / 2,
                  height: screenHeight / 3,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.green, // Set border color to green
                      width: screenWidth / 70, // Set border width
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: Padding(
                        padding: EdgeInsets.all(screenWidth / 10),
                        child: Container(
                          width: screenWidth * 0.9,
                          height: screenHeight,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.contain,
                              image: AssetImage('assets/Full Color Logo.png'),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                "By NIE",
                textAlign: TextAlign.center, // Align text center horizontally
                style: TextStyle(
                  fontSize: screenWidth / 10,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: screenHeight/20,
              ),

              // Long scrolling text
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: screenWidth / 10, right: screenWidth / 20),
                    child: AnimatedContainer(
                      duration: Duration(seconds: 5),
                      height: screenHeight * 0.8, // Adjust the height as needed
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.normal,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                                text:
                                    'Immerse yourself in a world of knowledge.\n'),
                            TextSpan(
                              text:
                                  'Whether you’re a student seeking understanding,\n',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: 'a teacher desiring inspiration, or\n',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                            TextSpan(
                              text: 'a lifelong learner chasing curiosity,\n',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                            TextSpan(
                              text:
                                  'AlphaU is your companion in the quest for\n',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: 'educational excellence.\n\n',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                            TextSpan(
                              text:
                                  'AlphaU – where education meets the airwaves.\n\n',
                              style: TextStyle(color: Colors.blue),
                            ),
                            TextSpan(
                              text: 'Advisor Board\n',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenHeight / 40),
                            ),
                            TextSpan(
                              text: 'Prasad Sethunaga (Director General)\n'
                                  'K. R. Pathmasiri (Deputy Director General)\n'
                                  'Chamila Edward (Senior Lecturer)\n',
                              style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontSize: screenHeight / 50),
                            ),
                            TextSpan(
                              text: '\nChief System Architect\n',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenHeight / 40),
                            ),
                            TextSpan(
                              text: 'Tharaka Leonardo Vipulaguna\n',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: screenHeight / 50),
                            ),
                            TextSpan(
                              text: '\nProject Management\n',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenHeight / 40),
                            ),
                            TextSpan(
                              text: 'Pradeep Ehan\n',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: screenHeight / 50),
                            ),
                            TextSpan(
                              text: '\nDevelopment Team\n',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenHeight / 40),
                            ),
                            TextSpan(
                              text: '- Kesara Dehipahawala\n'
                                  '- Ruwan Rathnayake\n'
                                  '- Kusal Wijekoon\n'
                                  '- Kasun Vichithra\n'
                                  '- Umesha Madushani\n'
                                  '- Hansi Tharushika\n',
                              style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontSize: screenHeight / 50),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
