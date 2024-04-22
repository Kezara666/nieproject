import 'dart:async';

import 'package:audio_wave/audio_wave.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nieproject/enviroment/api.dart';
import 'package:nieproject/models/ProgramProvider/Episodes_programs.dart';
import 'package:nieproject/pages/Menu/menu.dart';
import 'package:nieproject/services/functions/AudioController/audio_controller.dart';
import 'package:nieproject/widgets/hamburger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class TwoCirclePlayList extends StatefulWidget {
  TwoCirclePlayList({Key? key}) : super(key: key);

  @override
  _TwoCirclePlayListState createState() => _TwoCirclePlayListState();
}

class _TwoCirclePlayListState extends State<TwoCirclePlayList> {
  int selectedItemIndex = 0;
  var _sliderValue = 0.00;
  List<Map<String, dynamic>>? programs = null;

  AudioController audioController = Get.find();
  ProgramProvider _programProvider = Get.find();
  MenuWindow menuWindow = Get.find();
  late Timer _timer;
  ScrollController _scrollController =
      ScrollController(); // ScrollController added
  double _progressValue = 0;
  int _duration = 3;
  @override
  void dispose() {
    _scrollController.dispose(); // Dispose controller when state is disposed
    super.dispose();
  }

  List<Episode> episodes = List.empty();

  var firstVisibleIndex = 0;
  var lastVisibleIndex = 0;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    ;

    return Material(
      type: MaterialType.transparency,
      child: SafeArea(
        child: Container(
          decoration: const BoxDecoration(color: Color.fromRGBO(3, 20, 48, 1)),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //nav bar
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
                      icon: const Icon(Icons.more_vert),
                      color: Colors.white,
                    ),
                  ],
                ),
                //rounded programs
                Row(
                  children: [
                    Expanded(
                      // child: Container(
                      //   //margin: const EdgeInsets.symmetric(vertical: 20),
                      //   height: screenHeight / 4,
                      //   child: NotificationListener(
                      //     onNotification: (ScrollNotification notification) {
                      //       if (notification is ScrollUpdateNotification) {
                      //         // Assuming each list item has the same width and the list starts at index 0
                      //         final itemWidth = screenWidth /
                      //             3; // Replace with the actual width of your list items
                      //         firstVisibleIndex =
                      //             (notification.metrics.pixels / itemWidth)
                      //                 .floor();
                      //         lastVisibleIndex =
                      //             ((notification.metrics.pixels + screenWidth) /
                      //                     itemWidth)
                      //                 .floor();

                      //         print('First visible item: $firstVisibleIndex');
                      //         print('Last visible item: $lastVisibleIndex');

                      //         // If you need to setState based on which items are visible,
                      //         // make sure to do so only when the indices actually change to avoid performance issues.

                      //         // Optionally, you could use setState or other state management solutions here
                      //         // to keep track of the first and last visible items.

                      //         return true; // Return true to indicate the notification was handled.
                      //       }
                      //       return false;
                      //     },
                      //     child: widget.programs == null ?  LinearProgressIndicator (): ListView.builder(
                      //       controller: _scrollController,
                      //       scrollDirection: Axis.horizontal,
                      //       itemCount:
                      //           25, // Change this to your desired number of circles
                      //       itemBuilder: (BuildContext context, int index) {
                      //         return GestureDetector(
                      //           onTap: () {
                      //             setState(() {
                      //               selectedItemIndex =
                      //                   index; // Update the selected index
                      //             });
                      //             _centerItem(index); // Center the tapped item
                      //           },
                      //           child: Stack(
                      //             alignment: Alignment.center,
                      //             children: [
                      //               Container(
                      //                 margin: EdgeInsets.all(2.0),
                      //                 width: selectedItemIndex == index
                      //                     ? screenWidth /
                      //                         2 // Adjust as needed for selected item size
                      //                     : screenWidth /
                      //                         3, // Adjust as needed for default item size
                      //                 height: selectedItemIndex == index
                      //                     ? screenHeight /
                      //                         2 // Adjust as needed for selected item size
                      //                     : screenHeight /
                      //                         3, // Adjust as needed for selected item size
                      //                 decoration: BoxDecoration(
                      //                   shape: BoxShape.circle,
                      //                   color: Color.fromRGBO(3, 20, 48, 1),
                      //                   border: Border.all(
                      //                     color: Color.fromARGB(255, 91, 238,
                      //                         106), // Add border color for green circle
                      //                     width:
                      //                         2.0, // Adjust border width as needed
                      //                   ),
                      //                 ),
                      //               ),
                      //               Container(
                      //                 width: selectedItemIndex == index
                      //                     ? screenWidth /
                      //                         2.5 // Adjust as needed for selected item size
                      //                     : screenWidth /
                      //                         3.5, // Adjust as needed for default item size
                      //                 height: selectedItemIndex == index
                      //                     ? screenHeight /
                      //                         2.5 // Adjust as needed for selected item size
                      //                     : screenHeight / 3.5,
                      //                 decoration: BoxDecoration(
                      //                   shape: BoxShape.circle,
                      //                   color:
                      //                       Color.fromARGB(132, 244, 132, 255),
                      //                   border: Border.all(
                      //                     color: Color.fromARGB(255, 247, 249,
                      //                         248), // Add border color for green circle
                      //                     width:
                      //                         2.0, // Adjust border width as needed
                      //                   ),
                      //                 ),
                      //                 child: Center(
                      //                   child: ClipOval(
                      //                     child: Image.asset(
                      //                       'assets/a.gif', // Replace with your image asset path
                      //                       fit: BoxFit
                      //                           .cover, // Adjust image fit as needed
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //         );
                      //       },
                      //     ),
                      //   ),
                      // ),
                      child: CarouselSlider(
                        options: CarouselOptions(
                          enlargeCenterPage: true,
                          viewportFraction: 0.6,
                          aspectRatio: 2.0,
                          initialPage: 2,
                          autoPlay: false,
                          onPageChanged: (index, reason) {
                            // Access the currently active item from _programProvider.programs
                            Program activeProgram =
                                _programProvider.programs[index];
                            setState(() {
                              episodes = activeProgram.episodes!;
                            });
                            // Do something with the activeProgram
                          },
                        ),
                        items: _programProvider.programs
                            .map((item) => Padding(
                                  padding:
                                      EdgeInsets.all(8.0), // Add padding here
                                  child: Container(
                                    width: screenWidth / 2,
                                    height: screenHeight / 3,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors
                                            .green, // Set border color to green
                                        width: screenWidth /
                                            70, // Set border width
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            ClipOval(
                                              child: Image.network(
                                                "${appApi}${item.programThumbnail}",
                                                fit: BoxFit.cover,
                                                loadingBuilder:
                                                    (BuildContext context,
                                                        Widget child,
                                                        ImageChunkEvent?
                                                            loadingProgress) {
                                                  if (loadingProgress == null) {
                                                    // Image loaded, show the image
                                                    return child;
                                                  } else {
                                                    // Image is still loading, show CircularProgressIndicator
                                                    return CircularProgressIndicator();
                                                  }
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight / 30),
                //////////////////////////////////////Playing point///////////////////////////////////////
                GetBuilder<AudioController>(
                  builder: (_) => Container(
                    height: screenHeight / 7,
                    width: screenWidth / 1.1,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(61, 84, 112, 1),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //slider bar
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: screenHeight / 30,
                                ),
                                child: Text(
                                  _.programName,
                                  style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenHeight / 50,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: screenHeight / 60),
                              child: TextButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                  overlayColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                ),
                                onPressed: () {
                                  // Your button press code here
                                },
                                child: InkWell(
                                  onTap: () async {
                                    if (audioController.isPlay) {
                                      audioController.isPlay = false;
                                      await pause();
                                    } else {
                                      await audioController.play_function();
                                    }
                                  },
                                  child: Container(
                                      child: audioController.isPlay
                                          ? Image.asset(
                                              'assets/ply2.png',
                                              width: screenWidth / 15,
                                              height: screenHeight / 25,
                                            )
                                          : Image.asset(
                                              'assets/Play_Button.png',
                                              width: screenWidth / 15,
                                              height: screenHeight / 25,
                                            )),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: screenWidth / 40,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: screenHeight / 80,
                        ),
                        Expanded(
                          child: SliderTheme(
                            data: SliderThemeData(
                              thumbColor: Colors.green,
                              trackHeight: 1.0,
                              thumbShape:
                                  RectangularSliderThumbShape(thumbRadius: 4.0),
                              activeTrackColor: Colors.green,
                              inactiveTrackColor: Colors.white,
                            ),
                            child: Slider(
                              value: _.progress,
                              onChanged: (value) async {
                                await _.changeProgress(value);
                              },
                              // Other properties of the Slider...
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight / 40,
                        ),
                      ],
                    ),
                  ),
                ),
                ///////////////////////////////////////////Down episode list
                SizedBox(
                  height: screenHeight / 20,
                ),
                ///////////////////////////////////////////Down episode list
                SizedBox(
                  height: screenHeight / 20,
                ),
                ListEpisodes(screenWidth, screenHeight)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container ListEpisodes(double screenWidth, double screenHeight) {
    return Container(
      height: 200,
      child: ListView.builder(
        itemCount: episodes.length,
        itemBuilder: (context, index) {
          String time = "${DateTime.now().hour}:${DateTime.now().minute}";

          bool activeOther = false;
          return Padding(
            padding: EdgeInsets.only(left: screenWidth / 20),
            child: ListTile(
              onTap: () async {
                /////////////////////////////////////play episode
                onTapMethod(episodes[index]);
                Fluttertoast.showToast(
                  msg: audioController.isPlay ? "Start Playing" : "Pause Audio",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: const Color.fromARGB(255, 222, 14, 14),
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              },
              leading: Text(
                '${index + 1}',
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              title: Text(
                "${episodes[index].programName}" +
                    " " +
                    (episodes[index].episode != null &&
                            episodes[index].episode!.isNotEmpty
                        ? episodes[index].episode!
                        : "No episodes"),
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: screenHeight / 50,
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: screenWidth / 60,
                  ),
                  if (episodes[index].episode == audioController.episodeName &&
                      audioController.isPlay &&
                      audioController.programName ==
                          episodes[index].programName)
                    AudioWave(
                      height: 32,
                      width: 32,
                      spacing: 2.5,
                      animationLoop: 9999,
                      bars: [
                        AudioWaveBar(
                            heightFactor: 0.7,
                            color: Colors.lightBlueAccent), // Light blue bar
                        AudioWaveBar(
                            heightFactor: 0.8, color: Colors.blue), // Blue bar
                        AudioWaveBar(
                            heightFactor: 1,
                            color: Color.fromARGB(
                                255, 9, 117, 205)), // Cyan-like bar
                        AudioWaveBar(
                            heightFactor: 0.9,
                            color: Colors
                                .blue), // Specify the color here, e.g., same as the second bar
                      ],
                    ),
                  Text(
                    (episodes[index].episode != audioController.episodeName ||
                                (!audioController.isPlay && !activeOther)) ||
                            (episodes[index].episode ==
                                    audioController.episodeName &&
                                audioController.programName !=
                                    episodes[index].programName &&
                                !activeOther)
                        ? RemoveSeconds(episodes[index].duration)
                        : '',
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showPopupMenuDownload(
                          context, screenHeight, episodes[index]);
                    },
                    icon: Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

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

  void showPopupMenuDownload(
      BuildContext context, double screenHeight, dynamic listObject) async {
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
      handleMenuOption(result, listObject);
    }
  }

  Future<void> pause() async {
    try {
      await audioController.pause();
      audioController.isPlay = false;
      await audioController.audioPlayer.pause();
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
  }

  Future<void> onTapMethod(Episode program) async {
    if (audioController.isPlay) {
      this.audioController.isPlay = false;

      await pause();
    } else if (!audioController.isPlay) {
      this.audioController.isPlay = true;
      updateProgress(program.duration!);
      initAndPlayAudio("${appApi}${program.programFile}");
    }

    // Set the program name and episode name in the audio controller
    audioController.programName = program.programName ?? '';
    audioController.episodeName = program.episode ?? '';
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

  // Function to handle the selected menu option
  void handleMenuOption(String option, dynamic listObject) async {
    switch (option) {
      case 'Open':
        // Handle settings
        onTapMethod(listObject);

        break;
      case 'Download':
        // Handle change language
        await _requestPermission();
        await fileDownload(listObject);
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

  Future<void> _requestPermission() async {
    PermissionStatus status = await Permission.manageExternalStorage.request();

    if (status == PermissionStatus.granted) {
      Fluttertoast.showToast(
        msg: "permission granted ",
        toastLength:
            Toast.LENGTH_LONG, // Duration for which the toast is displayed
        gravity: ToastGravity.BOTTOM, // Position of the toast
        timeInSecForIosWeb: 1, // Duration for iOS (ignored on Android)
        backgroundColor: const Color.fromARGB(
            255, 222, 14, 14), // Background color of the toast
        textColor: Colors.white, // Text color of the toast
        fontSize: 16.0, // Font size of the toast message
      );
    } else {
      Fluttertoast.showToast(
        msg: "No permission to Storage please allow that",
        toastLength:
            Toast.LENGTH_LONG, // Duration for which the toast is displayed
        gravity: ToastGravity.BOTTOM, // Position of the toast
        timeInSecForIosWeb: 1, // Duration for iOS (ignored on Android)
        backgroundColor: const Color.fromARGB(
            255, 222, 14, 14), // Background color of the toast
        textColor: Colors.white, // Text color of the toast
        fontSize: 16.0, // Font size of the toast message
      );
      // Permission denied.
      // You might want to show a message to the user explaining why the permission is needed.
    }
  }

  Future<void> fileDownload(dynamic path) async {
    PermissionStatus status = await Permission.manageExternalStorage.status;

    if (status != PermissionStatus.granted) {
      await _requestPermission();
      return;
    }
    FileDownloader.downloadFile(
        url: "${appApi}${path['program_file']}",
        name: path['program_name'] + path['episode'], //(optional)
        onProgress: (fileName, progress) {
          Fluttertoast.showToast(
            msg: fileName.toString() +
                " " +
                "downloading " +
                progress.toString() +
                "%",
            toastLength:
                Toast.LENGTH_LONG, // Duration for which the toast is displayed
            gravity: ToastGravity.BOTTOM, // Position of the toast
            timeInSecForIosWeb: 1, // Duration for iOS (ignored on Android)
            backgroundColor: const Color.fromARGB(
                255, 222, 14, 14), // Background color of the toast
            textColor: Colors.white, // Text color of the toast
            fontSize: 16.0, // Font size of the toast message
          );
        },
        onDownloadCompleted: (String path) {
          print('FILE DOWNLOADED TO PATH: ');
          Fluttertoast.showToast(
            msg: "FILE DOWNLOADED TO PATH: " + path.toString(),
            toastLength:
                Toast.LENGTH_LONG, // Duration for which the toast is displayed
            gravity: ToastGravity.BOTTOM, // Position of the toast
            timeInSecForIosWeb: 1, // Duration for iOS (ignored on Android)
            backgroundColor: const Color.fromARGB(
                255, 222, 14, 14), // Background color of the toast
            textColor: Colors.white, // Text color of the toast
            fontSize: 16.0, // Font size of the toast message
          );
        },
        onDownloadError: (String error) {
          print('DOWNLOAD ERROR: $error');
          Fluttertoast.showToast(
            msg: "DOWNLOAD ERROR: $error",
            toastLength:
                Toast.LENGTH_LONG, // Duration for which the toast is displayed
            gravity: ToastGravity.BOTTOM, // Position of the toast
            timeInSecForIosWeb: 1, // Duration for iOS (ignored on Android)
            backgroundColor: const Color.fromARGB(
                255, 222, 14, 14), // Background color of the toast
            textColor: Colors.white, // Text color of the toast
            fontSize: 16.0, // Font size of the toast message
          );
        });
  }
}

String RemoveSeconds(String? duration) {
  if (duration != null && duration.isNotEmpty) {
    List<String> parts = duration.split(':');
    if (parts.length >= 2) {
      return duration =
          '${parts[0]}:${parts[1]}'; // Concatenate hours and minutes
    }
  }

  return "";
}

class RectangularSliderThumbShape extends SliderComponentShape {
  final double thumbRadius;

  const RectangularSliderThumbShape({
    this.thumbRadius = 6.0,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    Animation<double>? activationAnimation,
    Animation<double>? enableAnimation,
    bool? isDiscrete,
    TextPainter? labelPainter,
    RenderBox? parentBox,
    SliderThemeData? sliderTheme,
    TextDirection? textDirection,
    double? value,
    double? textScaleFactor,
    Size? sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final paint = Paint()
      ..color =
          sliderTheme?.thumbColor ?? const Color.fromARGB(255, 252, 252, 253)
      ..style = PaintingStyle.fill;

    final rect = Rect.fromCenter(
      center: center,
      width: thumbRadius * 2,
      height: thumbRadius * 4, // Adjust the height of the thumb as needed
    );

    canvas.drawRRect(
      RRect.fromRectAndRadius(
          rect, Radius.circular(4.0)), // Adjust corner radius as needed
      paint,
    );
  }
}
