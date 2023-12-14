import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:nieproject/enviroment/api.dart';
import 'package:nieproject/services/functions/AudioController/audio_controller.dart';
import 'package:nieproject/utils/colors.dart';
import 'package:nieproject/widgets/down-play-button-withnavbar.dart';
import 'package:nieproject/widgets/rounded-button.dart';

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
            gradient: linearGradient,
          ),
          child: SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          pause();
                          Get.back();
                        },
                        icon: const Icon(Icons.arrow_back),
                        color: Colors.white),
                    const Expanded(
                      child: Center(
                        child: CircleAvatar(
                          radius: 20.0, // Increase the radius to make it larger
                          backgroundImage: AssetImage('assets/logo.png'),
                          backgroundColor:
                              playAvatar, // Replace with your logo image
                        ),
                      ),
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
                      style: TextStyle(
                          fontFamily: 'YourFontFamily',
                          fontSize:
                              24, // Adjust the font size for the first text
                          fontWeight: FontWeight.bold,
                          color: Colors.white // Make it bold
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 85, 179, 96),
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            )),
                        child: TextButton.icon(
                            onPressed: () {
                              
                              audioController.PlayPlayList(widget.programs);
                            },
                            icon: const Icon(
                              Icons.play_arrow,
                              color: Colors.black,
                            ),
                            label: const Text(
                              'Listen',
                              style: TextStyle(
                                fontSize:
                                    16, // Adjust the font size for the second text
                                color: Color.fromARGB(
                                    255, 7, 7, 7), // Reduce opacity
                              ),
                            ))),
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
                  itemCount: widget
                      .programs.length, // Replace with your desired item count
                  itemBuilder: (context, index) {
                    // Simulated time
                    String time =
                        "${DateTime.now().hour}:${DateTime.now().minute}";

                    return ListTile(
                      onTap: () {
                        Fluttertoast.showToast(
                          msg: audioController.isPlay
                              ? "Pause Audio"
                              : "Start Playing",
                          toastLength: Toast
                              .LENGTH_LONG, // Duration for which the toast is displayed
                          gravity: ToastGravity.BOTTOM, // Position of the toast
                          timeInSecForIosWeb:
                              1, // Duration for iOS (ignored on Android)
                          backgroundColor: const Color.fromARGB(255, 222, 14,
                              14), // Background color of the toast
                          textColor: Colors.white, // Text color of the toast
                          fontSize: 16.0, // Font size of the toast message
                        );

                        setState(() async {
                          if (audioController.isPlay) {
                            this.audioController.isPlay = false;
                            await pause();
                          } else if (!audioController.isPlay) {
                            this.audioController.isPlay = true;
                            initAndPlayAudio(
                                "${appApi}${widget.programs[index]['program_file']}");
                          }
                          audioController.programName =
                              widget.programs[index]['program_name'];
                        });
                      },
                      leading: Text(
                        '$index',
                        style: TextStyle(
                            color: Colors
                                .white), // Number on the left corner with white text color
                      ),
                      title: Text(
                        'Episode: ' + widget.programs[index]['episode'],
                        style: TextStyle(
                            color: Colors
                                .white), // Main text with white text color
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.programs[index]['episode_time'] ?? '',
                            style: TextStyle(
                                color:
                                    Colors.white), // Time with white text color
                          ),
                          IconButton(
                            onPressed: () {
                              updateProgress(
                                  widget.programs[index]['episode_time']);
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
                GetBuilder<AudioController>(
                  builder: (controller) {
                    // Use the value from the controller to update the UI
                    return playButtonWithDownBar(
                        screenHeight,
                        screenWidth,
                        _progressValue,
                        audioController.episodeName,
                        this.author,
                        audioController.isPlay);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    // Schedule a repeating timer that runs every minute
    _timer =Timer.periodic(Duration(seconds: 1), (Timer timer) {
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

  void updateProgress(String fullProgramTime) {
    audioController.GetAudioServiceTime(convertTimeToSeconds(fullProgramTime));
    setState(() {
      this._progressValue = audioController.progress;
    });
  }

  Future<void> pause() async {
    try {
      await audioController.pause();
      audioController.isPlay =false;
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
