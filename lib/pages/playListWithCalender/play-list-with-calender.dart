import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nieproject/enviroment/api.dart';
import 'package:nieproject/enviroment/font.dart';
import 'package:nieproject/models/EpisodeProvider/program_episode.dart';
import 'package:nieproject/models/ProgramProvider/Episodes_programs.dart';
import 'package:nieproject/pages/Menu/menu.dart';
import 'package:nieproject/pages/playList/program_list.dart';
import 'package:nieproject/pages/playRecoding/play-recoding.dart';
import 'package:nieproject/pages/player/player.dart';
import 'package:nieproject/pages/twoCirclePlayListWindow/two_circle_list_window.dart';
import 'package:nieproject/services/functions/AudioController/audio_controller.dart';
import 'package:nieproject/utils/colors.dart';
import 'package:nieproject/widgets/calender-widow-navbar.dart';
import 'package:nieproject/widgets/hamburger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:audio_wave/audio_wave.dart';
import 'package:intl/intl.dart';

class ProgramListCalenderWindow extends StatefulWidget {
  const ProgramListCalenderWindow({Key? key});

  @override
  State<ProgramListCalenderWindow> createState() =>
      _ProgramListCalenderWindow();
}

class _ProgramListCalenderWindow extends State<ProgramListCalenderWindow> {
  AudioController audioController = Get.find();
  OnAirScreen onAirScreen = Get.find();
  PlayRecodingWindow playRecodingWindow = Get.find();
  double isPressed = 0;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  MenuWindow menuWindow = Get.find();
  CalendarController _controller = CalendarController();

  EpisodeProvider episodeProvider = Get.find();
  List<ProgramEpisode> _episodes = List.empty();

  //to be remove
  TwoCirclePlayList _twoCirclePlayList = Get.find();

  Future<void> fetchData() async {
    await episodeProvider.fetchEpisodes().then((value) {
      _episodes = value; // Update the UI after fetching episodes
    }).catchError((error) {
      print('Error fetching episodes: $error');
    });
  }

  @override
  void initState() {
    super.initState();

    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    ;

    return Material(
        type: MaterialType.transparency,
        child: SafeArea(
            child: Container(
                decoration:
                    const BoxDecoration(color: Color.fromRGBO(3, 20, 48, 1)),
                child: SingleChildScrollView(
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
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
                  Column(
                    children: [
                      Center(
                        child: Text(
                          translate('Choose by Date', language: language),
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.white,
                        thickness: 1.0,
                      ),
                      Padding(
                        padding: screenHeight > 700
                            ? EdgeInsets.all(screenWidth / 20)
                            : EdgeInsets.all(0),
                        child: Padding(
                          padding: EdgeInsets.all(screenWidth / 30),
                          child: Container(
                            height: screenHeight / 3,
                            decoration: BoxDecoration(
                              color: playAvatar,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Transform.scale(
                              scaleY: 0.8,
                              child: SfCalendar(
                                onSelectionChanged: (calendarSelectionDetails) {
                                  DateTime? date =
                                      calendarSelectionDetails.date;

                                  setState(() {
                                    print(date);
                                    if (_selectedDay == date) {}
                                    _selectedDay = date;
                                    String formattedDate =
                                        DateFormat('yyyy-MM-dd')
                                            .format(_selectedDay!);
                                    _episodes = episodeProvider
                                        .filterEpisodesByDate(formattedDate);
                                  });
                                },
                                view: CalendarView.month,
                                controller: _controller,
                                headerHeight: screenHeight / 20,
                                showNavigationArrow: true,
                                headerStyle: CalendarHeaderStyle(
                                    textStyle: TextStyle(color: Colors.white),
                                    backgroundColor: playAvatar),
                                cellBorderColor: playAvatar,
                                monthViewSettings: MonthViewSettings(
                                  appointmentDisplayMode:
                                      MonthAppointmentDisplayMode.appointment,
                                  showAgenda: false,
                                  navigationDirection:
                                      MonthNavigationDirection.horizontal,
                                  appointmentDisplayCount: 3,
                                  dayFormat: 'EEE',
                                  agendaStyle: AgendaStyle(
                                    backgroundColor: Colors.white,
                                    appointmentTextStyle: TextStyle(
                                      fontSize: 13,
                                      color: const Color.fromARGB(
                                          255, 247, 246, 246),
                                      fontWeight: FontWeight.w500,
                                    ),
                                    dayTextStyle: TextStyle(
                                      fontSize: 13,
                                      color: const Color.fromARGB(
                                          255, 245, 244, 244),
                                      fontWeight: FontWeight.w500,
                                    ),
                                    dateTextStyle: TextStyle(
                                      fontSize: 25,
                                      color: const Color.fromARGB(
                                          255, 245, 243, 243),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  monthCellStyle: MonthCellStyle(
                                    backgroundColor: playAvatar,
                                    textStyle: TextStyle(color: Colors.white),
                                    todayBackgroundColor: playAvatar,
                                    trailingDatesBackgroundColor: playAvatar,
                                    leadingDatesBackgroundColor: playAvatar,
                                    // cellBorderColor: Colors.transparent,
                                  ),
                                ),
                                selectionDecoration: BoxDecoration(
                                  backgroundBlendMode: BlendMode.colorBurn,
                                  color: const Color.fromARGB(255, 207, 204,
                                      204), // Change this color as desired
                                  shape: BoxShape
                                      .circle, // You can also use other shapes
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  /////////////////////////////////////////////////////////////////////////////// LIST OF EPISODES
                  GetBuilder<AudioController>(
                    builder: (_) => Container(
                      height: 200,
                      child: ListView.builder(
                        itemCount: _episodes.length,
                        itemBuilder: (context, index) {
                          String time =
                              "${DateTime.now().hour}:${DateTime.now().minute}";

                          return Padding(
                            padding: EdgeInsets.only(left: screenWidth / 20),
                            child: ListTile(
                              onTap: () async {
                                /////////////////////////////////////play episode
                                onTapMethod(_episodes[index]);
                                Fluttertoast.showToast(
                                  msg: audioController.isPlay
                                      ? "Start Playing"
                                      : "Pause Audio",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor:
                                      const Color.fromARGB(255, 222, 14, 14),
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
                                (_episodes[index].programName.isNotEmpty
                                    ? _episodes[index].programName
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
                                  if (_episodes[index].episode ==
                                          audioController.episodeName &&
                                      audioController.isPlay &&
                                      audioController.programName ==
                                          _episodes[index].programName)
                                    AudioWave(
                                      height: 32,
                                      width: 32,
                                      spacing: 2.5,
                                      animationLoop: 9999,
                                      bars: [
                                        AudioWaveBar(
                                            heightFactor: 0.7,
                                            color: Colors
                                                .lightBlueAccent), // Light blue bar
                                        AudioWaveBar(
                                            heightFactor: 0.8,
                                            color: Colors.blue), // Blue bar
                                        AudioWaveBar(
                                            heightFactor: 1,
                                            color: Color.fromARGB(255, 9, 117,
                                                205)), // Cyan-like bar
                                        AudioWaveBar(
                                            heightFactor: 0.9,
                                            color: Colors
                                                .blue), // Specify the color here, e.g., same as the second bar
                                      ],
                                    ),
                                  if (_episodes[index].episode !=
                                          audioController.episodeName ||
                                      !audioController.isPlay && !(_episodes[index].episode ==
                                          audioController.episodeName &&
                                      audioController.programName !=
                                          _episodes[index].programName))
                                    Text(
                                      RemoveSeconds(_episodes[index].duration),
                                      style: GoogleFonts.montserrat(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  if (_episodes[index].episode ==
                                          audioController.episodeName &&
                                      audioController.programName !=
                                          _episodes[index].programName)
                                    Text(
                                      RemoveSeconds(_episodes[index].duration),
                                      style: GoogleFonts.montserrat(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  IconButton(
                                    onPressed: () {
                                      showPopupMenuDownload(context,
                                          screenHeight, _episodes[index]);
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
                    ),
                  ),
                  //////////////////////////////////////////////////?Down Nava Bar
                  calenderWidowNavbar(screenHeight, screenWidth)
                ])))));
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
        Overlay.of(context).context.findRenderObject() as RenderBox;
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

  Future<void> onTapMethod(ProgramEpisode program) async {
    if (audioController.isPlay) {
      this.audioController.isPlay = false;
      await pause();
      this.audioController.isPlay = true;
      updateProgress(program.duration!);
      initAndPlayAudio("${appApi}${program.programFile}");

    } else if (!audioController.isPlay) {
      this.audioController.isPlay = true;
      updateProgress(program.duration!);
      initAndPlayAudio("${appApi}${program.programFile}");
    }

    // Set the program name and episode name in the audio controller
    audioController.programName = program.programName ?? '';
    audioController.episodeName = program.episode ?? '';
    audioController.update();

    // audioController.PlayPlayList(episodeProvider.episodes);
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
