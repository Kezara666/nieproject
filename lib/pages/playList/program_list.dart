import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nieproject/enviroment/api.dart';
import 'package:nieproject/services/functions/AudioController/audio_controller.dart';
import 'package:nieproject/utils/colors.dart';
import 'package:nieproject/widgets/down-play-button-withnavbar.dart';
import 'package:nieproject/widgets/hamburger.dart';
import 'package:nieproject/widgets/rounded-button.dart';
import 'package:nieproject/widgets/show_popup_menu_program_download.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class ProgramListWindow extends StatefulWidget {
  final List<Map<String, dynamic>> programs;
  const ProgramListWindow({Key? key, required this.programs});

  @override
  State<ProgramListWindow> createState() => _ProgramListWindowState();
}

class _ProgramListWindowState extends State<ProgramListWindow> {
  AudioController audioController = Get.find();
  late Timer _timer;

  double _progressValue = 0;

  String author = "Author";

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
          decoration: const BoxDecoration(
            color: Color.fromRGBO(3, 20, 48, 1),
          ),
          child: GetBuilder<AudioController>(
            builder: (controller) {
              // Use the value from the controller to update the UI
              return Column(
                children: [
                  SizedBox(
                    height: screenHeight / 25,
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            pause();
                            Get.back();
                          },
                          icon: const Icon(Icons.arrow_back),
                          color: Colors.white),
                      Expanded(
                        child: Center(
                          child: Container(
                            child: CircleAvatar(
                              radius:
                                  20.0, // Increase the radius to make it larger
                              backgroundImage: AssetImage('assets/logo.png'),
                              backgroundColor:
                                  Colors.white, // Replace with your logo image
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            showPopupMenu(context);
                          },
                          icon: const Icon(Icons.drag_indicator_rounded),
                          color: Colors.white),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight / 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.green
                                .shade400, // Replace with your desired border color
                            width: 10.0, // Adjust the border width as needed
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 100.0,
                          backgroundColor: playAvatar, // Background color
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: screenHeight / 30,
                  ),
                  GetBuilder<AudioController>(
                    builder: (controller) {
                      // Use the value from the controller to update the UI
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            controller.programName,
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        this.author,
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight / 60,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 85, 179, 96),
                              borderRadius: BorderRadius.all(
                                Radius.circular(50),
                              )),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: TextButton.icon(
                                onPressed: () {
                                  audioController.PlayPlayList(widget.programs);
                                },
                                icon: const Icon(
                                  Icons.play_arrow,
                                  color: Colors.black,
                                ),
                                label: Text(
                                  'Listen',
                                  style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                          )),
                      SizedBox(
                        width: screenWidth / 30,
                      ),
                      Buttons.buttonRound()
                    ],
                  ),
                  SizedBox(
                    height: screenWidth / 30,
                  ),
                  Expanded(
                      child: ListView.builder(
                    itemCount: widget.programs
                        .length, // Replace with your desired item count
                    itemBuilder: (context, index) {
                      // Simulated time
                      String time =
                          "${DateTime.now().hour}:${DateTime.now().minute}";

                      return ListTile(
                        onTap: () async {
                          Fluttertoast.showToast(
                            msg: audioController.isPlay
                                ? "Pause Audio"
                                : "Start Playing",
                            toastLength: Toast
                                .LENGTH_LONG, // Duration for which the toast is displayed
                            gravity:
                                ToastGravity.BOTTOM, // Position of the toast
                            timeInSecForIosWeb:
                                1, // Duration for iOS (ignored on Android)
                            backgroundColor: const Color.fromARGB(255, 222, 14,
                                14), // Background color of the toast
                            textColor: Colors.white, // Text color of the toast
                            fontSize: 16.0, // Font size of the toast message
                          );
                          onTapMethod(widget.programs[index]);
                          
                        },
                        leading: Text(
                          '$index',
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ), // Number on the left corner with white text color
                        ),
                        title: Text(
                          'Episode: ' + widget.programs[index]['episode'],
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ), // Main text with white text color
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (widget.programs[index]['episode'] ==
                                    audioController.episodeName &&
                                audioController.isPlay)
                              WaveWidget(
                                config: CustomConfig(
                                  gradients: [
                                    [
                                      const Color.fromARGB(255, 243, 245, 247),
                                      Color.fromARGB(255, 49, 53, 56)
                                    ],
                                    [
                                      const Color.fromARGB(255, 108, 110, 111)
                                          .withOpacity(0.5),
                                      const Color.fromARGB(255, 212, 215, 216)
                                          .withOpacity(0.5)
                                    ],
                                    [
                                      const Color.fromARGB(255, 245, 246, 247)
                                          .withOpacity(0.8),
                                      const Color.fromARGB(255, 188, 204, 216)
                                          .withOpacity(0.8)
                                    ],
                                    [
                                      const Color.fromARGB(255, 222, 224, 227),
                                      const Color.fromARGB(255, 99, 104, 107)
                                    ],
                                  ],
                                  durations: [35000, 19440, 10800, 6000],
                                  heightPercentages: [0.25, 0.26, 0.28, 0.31],
                                ),
                                size: Size(screenWidth / 20, screenHeight / 50),
                                waveAmplitude: 10,
                              ),
                            if (widget.programs[index]['episode'] !=
                                    audioController.episodeName ||
                                !audioController.isPlay)
                              Text(
                                widget.programs[index]['duration'] ?? '',
                                style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ), // Time with white text color
                              ),
                            IconButton(
                              onPressed: () {
                                // updateProgress(
                                //     widget.programs[index]['duration']);
                                showPopupMenuDownload(context, screenHeight,widget.programs[index]);
                              },
                              icon: Icon(
                                Icons.more_vert,
                                color: Colors
                                    .white, // Three-dots icon with white color
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )),
                  playButtonWithDownBar(
                      screenHeight,
                      screenWidth,
                      controller.progress,
                      audioController.episodeName,
                      this.author,
                      audioController.isPlay)
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    // Schedule a repeating timer that runs every minute
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      // Your code to be executed every minute goes here
      // This function will be called every minute
      // Update the state or perform any necessary tasks

      // Example: Update a variable and trigger a rebuild
      setState(() {
        this._progressValue = audioController.progress;
      });
    });
  }

  @override
  void dispose() {
    // Cancel the periodic timer in the dispose method
    _timer.cancel();

    super.dispose();
  }

  int convertTimeToSeconds(String timeString) {
    List<String> timeComponents = timeString.split(':');

    if (timeComponents.length == 3) {
      int hours = int.parse(timeComponents[0]);
      int minutes = int.parse(timeComponents[1]);
      int seconds = int.parse(timeComponents[2]);

      int totalSeconds = hours * 3600 + minutes * 60 + seconds;
      return totalSeconds;
    } else {
      // Handle invalid time format
      print('Invalid time format');
      return 0;
    }
  }

  void showPopupMenuDownload(
    BuildContext context,
    double screenHeight,
    dynamic listObject
  ) async {
    final RenderBox overlay =
        Overlay.of(context)!.context.findRenderObject() as RenderBox;
    final Offset offset = Offset(overlay.size.width - 50,
        screenHeight / 1.5); // Adjust the values based on your UI
    final result = await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(offset.dx, offset.dy, 0, 0),
      items: [
        PopupMenuItem<String>(
          value: 'Open',
          child: const Text('Open'),
        ),
        PopupMenuItem<String>(
          value: 'Download',
          child: const Text('Download'),
        ),
      ],
    );

    // Handle the selected option
    if (result != null) {
      handleMenuOption(result,listObject);
    }
  }

  // Function to handle the selected menu option
  void handleMenuOption(String option,dynamic listObject) async{
    switch (option) {
      case 'Open':
        // Handle settings
        onTapMethod(listObject);

        break;
      case 'Download':
        // Handle change language
        break;
      case 'about':
        // Handle about
        break;
      case 'logout':
        // Handle logout
        break;
      // Add more cases for additional options if needed
    }
  }

  Future<void> onTapMethod(dynamic program) async {
    if (audioController.isPlay) {
      this.audioController.isPlay = false;

      await pause();
    } else if (!audioController.isPlay) {
      this.audioController.isPlay = true;
      updateProgress(program['duration']);
      initAndPlayAudio("${appApi}${program['program_file']}");
    }
    audioController.programName = program['program_name'];
    audioController.episodeName = program['episode'];
  }

  void updateProgress(String fullProgramTime) {
    audioController.GetAudioServiceTime(convertTimeToSeconds(fullProgramTime));
  }

  Future<void> pause() async {
    try {
      await audioController.pause();
      audioController.isPlay = false;
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
}
