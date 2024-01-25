import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nieproject/pages/player/player.dart';

import 'package:nieproject/utils/colors.dart';
import 'package:nieproject/widgets/background-gradiant-button.dart';
import 'package:nieproject/widgets/calender-widow-navbar.dart';
import 'package:nieproject/widgets/custom-curve-play-rocoding-window.dart';
import 'package:nieproject/widgets/next-button.dart';
import 'package:nieproject/widgets/prev-button.dart';

class PlayRecodingWindow extends StatefulWidget {
  const PlayRecodingWindow({
    super.key,
  });

  @override
  State<PlayRecodingWindow> createState() => _PlayRecodingWindowState();
}

class _PlayRecodingWindowState extends State<PlayRecodingWindow> {
  OnAirScreen mainWindow = Get.find();
  double volume = 0.8;
  void updateVolume(double newValue) {
    setState(() {
      volume = newValue;
      print(volume);
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        // await showDialog or Show add banners or whatever
        // return true if the route to be popped
        return false; // return false if you want to disable device back button click
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(3, 20, 48, 1)
          ),
          child: SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.to(() => mainWindow);
                        },
                        icon: const Icon(Icons.arrow_circle_left_rounded),
                        color: Colors.white),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.queue_music_outlined),
                        color: Colors.white),
                    Expanded(
                      child: Center(
                        child: CircleAvatar(
                          radius: 20.0, // Increase the radius to make it larger
                          backgroundImage: AssetImage('assets/logo.png'),
                          backgroundColor:
                              Colors.white, // Replace with your logo image
                        ),
                      )
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.drag_indicator_rounded),
                        color: Colors.white),
                  ],
                ),
                SizedBox(
                  height: screenHeight / 25,
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                        radius: screenHeight / 5,
                        backgroundColor: backgroundColor,
                        backgroundImage: AssetImage('assets/a.gif')),
                    GestureDetector(
                      onPanUpdate: (details) async {
                        // Calculate the new volume based on the drag gesture
                        double newVolume = volume - details.delta.dy / 200;
                        // Ensure the volume stays within 0.0 and 1.0
                        newVolume = newVolume.clamp(0.0, 1.0);
                        updateVolume(newVolume);
                        print(double.parse(volume.toStringAsFixed(1)));
                      },
                      child: CustomPaint(
                        painter: CurvePainter(volume, screenHeight),
                        child: SizedBox(
                          width: screenWidth * 0.8,
                          height: screenHeight / 10,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: screenWidth / 30,
                    ),
                    Expanded(
                      child: Text(
                        textAlign: TextAlign.start,
                        '0.00',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Text(
                      '30.32',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      width: screenWidth / 30,
                    ),
                  ],
                ),
                SizedBox(
                  height: screenWidth / 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Program Title",
                      style: TextStyle(
                          fontFamily: 'YourFontFamily',
                          fontSize:
                              24, // Adjust the font size for the first text
                          fontWeight: FontWeight.bold,
                          color: Colors.white // Make it bold
                          ),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenWidth / 30,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Author",
                      style: TextStyle(
                        fontSize:
                            16, // Adjust the font size for the second text
                        color:
                            Color.fromARGB(255, 74, 74, 74), // Reduce opacity
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight / 60,
                ),
                SizedBox(
                  height: screenWidth / 30,
                ),
                Expanded(
                  child: Row(
                    children: [
                      SizedBox(
                        width: screenWidth / 10,
                      ),
                      Expanded(
                        child: BackGroundGradiantPrevButtun(
                          height: screenHeight * 2,
                          
                        ),
                      ),
                      SizedBox(
                        width: screenWidth / 10,
                      ),
                      Expanded(
                        child: BackGroundGradiantButtun(
                          height: screenHeight * 2,
                          
                        ),
                      ),
                      SizedBox(
                        width: screenWidth / 10,
                      ),
                      Expanded(
                        child: BackGroundGradiantNextButtun(
                          height: screenHeight * 2,
                          
                        ),
                      ),
                      SizedBox(
                        width: screenWidth / 10,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: screenWidth / 10,
                ),
                calenderWidowNavbar(screenHeight, screenWidth)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
