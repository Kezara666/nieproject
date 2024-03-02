import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nieproject/enviroment/api.dart';
import 'package:nieproject/models/program.dart';
import 'package:nieproject/pages/auth/login.dart';
import 'package:nieproject/pages/chat/chat.dart';
import 'package:nieproject/pages/playListWithCalender/play-list-with-calender.dart';
import 'package:nieproject/pages/playRecoding/play-recoding.dart';
import 'package:nieproject/services/functions/AudioController/audio_controller.dart';
import 'package:nieproject/utils/colors.dart';
import 'package:nieproject/widgets/sound-controller-paint.dart';
import 'package:google_fonts/google_fonts.dart';

class OnAirScreen extends StatefulWidget {
  @override
  _OnAirScreenState createState() => _OnAirScreenState();
}

class _OnAirScreenState extends State<OnAirScreen> {
  double volume = 0.5; // Initial volume value
  final AudioPlayer audioPlayer = AudioPlayer();
  String audioStreamUrl = 'https://172.212.81.114/live';
  ProgramListCalenderWindow programListCalenderWindow =
      Get.find<ProgramListCalenderWindow>();
  AudioController audioController = Get.find();
  PlayRecodingWindow playRecodingWindow = Get.find();
  LoginPage loginWindow = Get.find();

  // Function to fetch data from the PHP script
  Future<void> fetchData() async {
    try {
      initAndPlayAudio(audioStreamUrl);
    } catch (e) {
      print('error' + 'Error fetching data: $e');
    }
  }

  // Async function to initialize and play audio
  Future<void> initAndPlayAudio(String url) async {
    try {
      await audioController.initAndPlayAudio(url);
    } catch (e) {
      print('Error playing audio: $e');

      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength:
            Toast.LENGTH_LONG, // Duration for which the toast is displayed
        gravity: ToastGravity.BOTTOM, // Position of the toast
        timeInSecForIosWeb: 1, // Duration for iOS (ignored on Android)
        backgroundColor: const Color.fromARGB(
            255, 222, 14, 14), // Background color of the toast
        textColor: Colors.white, // Text color of the toast
        fontSize: 16.0, // Font size of the toast message
      );
    }
  }

  void updateVolume(double newValue) {
    setState(() {
      volume = newValue;
      print(volume);
    });
  }

  @override
  void initState() {
    super.initState();
    // Call the async function to initialize and play audio when the widget is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchData(); // Move your async call to here
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    print("height" + screenHeight.toString());
    return WillPopScope(
      onWillPop: () async {
        // await showDialog or Show add banners or whatever
        // return true if the route to be popped
        return false; // return false if you want to disable device back button click
      },
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(color: Color.fromRGBO(3, 20, 48, 1)),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.queue_music_outlined),
                        color: Colors.transparent),
                    Expanded(
                        child: Center(
                      child: CircleAvatar(
                        radius: 20.0, // Increase the radius to make it larger
                        backgroundImage: AssetImage('assets/logo.png'),
                        backgroundColor:
                            Colors.white, // Replace with your logo image
                      ),
                    )),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.more_vert),
                        color: Colors.white),
                  ],
                ),

                SizedBox(height: screenHeight * .0246305418719212),
                // Larger Avatar with Logo
                Container(
                  width: screenHeight *
                      0.1231527093596059 *
                      2, // Adjust the container width as needed
                  height: screenHeight *
                      0.1231527093596059 *
                      2, // Adjust the container height as needed
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Color.fromARGB(255, 10, 115, 172), // Border color
                      width: 5.0, // Border width
                    ),
                  ),
                  child: CircleAvatar(
                    radius: screenHeight *
                        0.1231527093596059, // Increase the radius to make it larger
                    backgroundImage: AssetImage('assets/a.gif'),
                    backgroundColor: playAvatar, // Replace with your logo image
                  ),
                ),
                SizedBox(height: screenHeight * .0246305418719212),

                Container(
                  height: screenHeight / 12,
                  width: screenWidth / 3,
                  decoration: BoxDecoration(
                    gradient: onFire,
                    border: Border.all(
                        color: Colors.black, width: 3), // Black border
                  ),
                  padding: const EdgeInsets.all(10),
                  child: TextButton(
                    onPressed: () {
                      Get.to(() => playRecodingWindow);
                    },
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        'ON AIR',
                        style: GoogleFonts.zillaSlab(
                          color: const Color.fromARGB(255, 254, 253, 253),
                          fontSize: screenHeight / 35,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * .0246305418719212),
                Text(
                  'NIE NEWS', // Display the volume percentage
                  style: GoogleFonts.playfairDisplay(
                    color: const Color.fromARGB(255, 254, 253, 253),
                    fontSize: 20,
                    fontWeight: FontWeight.w100,
                  ),
                ),
                SizedBox(height: screenHeight * .0246305418719212),
                Container(
                  width: screenWidth * 0.5333333333333333,
                  height: screenHeight * 0.2463054187192118,
                  child: GestureDetector(
                    onPanUpdate: (details) async {
                      // Calculate the new volume based on the drag gesture
                      double newVolume = volume - details.delta.dy / 200;
                      // Ensure the volume stays within 0.0 and 1.0
                      newVolume = newVolume.clamp(0.0, 1.0);
                      updateVolume(newVolume);
                      print(double.parse(volume.toStringAsFixed(1)));
                      await audioController.audioPlayer
                          .setVolume(double.parse(volume.toStringAsFixed(1)));
                    },
                    child: CustomPaint(
                      painter: SoundControllerPainter(volume),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight / 200),
                // IconButton(
                //   onPressed: () {
                //     // Increase volume when the first icon button is pressed
                //     audioController.isPlay = false;
                //     audioController.audioPlayer.pause();
                //   },
                //   icon: new Image.asset("assets/stop.png"),
                //   iconSize: 40,
                // ),
                SizedBox(height: screenHeight / 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          // Your action for this button
                          Get.to(() => loginWindow);
                        },
                        icon: SizedBox(
                          width: 50, // Adjust size as needed
                          height: 50,
                          child: Image.asset("assets/chat.png"),
                        ),
                      ),
                    ),
                    // Add any desired spacing between buttons if necessary
                    // SizedBox(width: yourDesiredSpacing),
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          // Your action for this button
                          audioController.isPlay = false;
                          audioController.audioPlayer.pause();
                          Get.to(() => programListCalenderWindow);
                        },
                        icon: SizedBox(
                          width: 50, // Adjust size as needed
                          height: 50,
                          child: Image.asset("assets/pause.png"),
                        ),
                      ),
                    ),
                    // If you need more buttons, continue adding them in the same pattern:
                    Expanded(
                      child: IconButton(
                        onPressed: () {},
                        icon: SizedBox(
                          width: 50, // Specify the width of the image
                          height: 50,
                          child: Image.asset("assets/hanlde.png"),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
