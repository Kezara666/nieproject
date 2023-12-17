import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nieproject/enviroment/api.dart';
import 'package:nieproject/pages/playList/program_list.dart';
import 'package:nieproject/pages/playRecoding/play-recoding.dart';
import 'package:nieproject/pages/player/player.dart';
import 'package:nieproject/services/functions/AudioController/audio_controller.dart';
import 'package:nieproject/utils/colors.dart';
import 'package:nieproject/widgets/calender-widow-navbar.dart';
import 'package:nieproject/widgets/hamburger.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class ProgramListCalenderWindow extends StatefulWidget {
  const ProgramListCalenderWindow({Key? key});

  @override
  State<ProgramListCalenderWindow> createState() =>
      _ProgramListCalenderWindow();
}

class _ProgramListCalenderWindow extends State<ProgramListCalenderWindow> {
  ProgramListWindow programListWindow = Get.find();
  AudioController audioController = Get.find();
  OnAirScreen onAirScreen = Get.find();
  PlayRecodingWindow playRecodingWindow = Get.find();
  double isPressed = 0;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  List<dynamic> programsList = [];

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('${appApi}api/programs'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> programs = data['programs_list'];

      // Group items by program_name
      final groupedPrograms = groupBy(programs, (obj) => obj['program_name']);

      setState(() {
        this.programsList = groupedPrograms.values.toList();
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    // Call the async function to initialize and play audio when the widget is initialized
    Fluttertoast.showToast(
      msg: "If you need choose program by date press a date ",
      toastLength:
          Toast.LENGTH_LONG, // Duration for which the toast is displayed
      gravity: ToastGravity.BOTTOM, // Position of the toast
      timeInSecForIosWeb: 3, // Duration for iOS (ignored on Android)
      backgroundColor: const Color.fromARGB(
          255, 222, 14, 14), // Background color of the toast
      textColor: Colors.white, // Text color of the toast
      fontSize: 16.0, // Font size of the toast message
    );
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    var children2 = [
      Row(
        children: [
          IconButton(
              onPressed: () {
                Get.to(() => onAirScreen);
              },
              icon: const Icon(Icons.arrow_back),
              color: Colors.white),
          Expanded(
            child: Center(
                child: Center(
              child: CircleAvatar(
                  radius: 20.0, // Increase the radius to make it larger
                  backgroundImage: AssetImage('assets/logo.png'),
                  backgroundColor: Colors.white // Replace with your logo image
                  ),
            )
                // child: CircleAvatar(
                //   radius: 20.0, // Increase the radius to make it larger
                //   backgroundImage: AssetImage('assets/logo.png'),
                //   backgroundColor:
                //       playAvatar, // Replace with your logo image
                // ),
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
      if (this.isPressed == 0)
        SizedBox(
          height: screenHeight / 60,
        ),
      if (this.isPressed == 0) CalenderContainer(),
      if (this.isPressed == 0)
        Expanded(child: ContainerCalender(this.isPressed)),
      if (this.isPressed == 1)
        Expanded(child: ContainerCalender(this.isPressed)),
      if (this.isPressed == 1) CalenderContainer(),
      if (this.isPressed == 1)
        SizedBox(
          height: screenHeight / 60,
        ),
      calenderWidowNavbar(screenHeight, screenWidth),
    ];
    return WillPopScope(
      onWillPop: () async {
        // await showDialog or Show add banners or whatever
        // return true if the route to be popped
        return false; // return false if you want to disable device back button click
      },
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(3, 20, 48, 1)
          ),
          child: SafeArea(
            child: Column(
              children: children2,
            ),
          ),
        ),
      ),
    );
  }

  Widget ContainerCalender(double isPressed) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              'Choose by Program',
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(
          height: screenHeight / 50,
        ),
        Divider(
          color: Colors.white,
          thickness: 2.0,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: this
                .programsList
                .length, // Replace with your desired item count
            itemBuilder: (context, index) {
              // Simulated time
              final program = this.programsList[index];
              String time = "${DateTime.now().hour}:${DateTime.now().minute}";
              // Calculate the sum of 'duration' for each group
              return ListTile(
                  leading: Text(
                    '${program[0]['program_name']}',
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ), // Number on the left corner with white text color
                  ),
                  onTap: () {
                    if (isPressed == 0) {
                      audioController.programName = program[0]['program_name'];
                      Get.to(() => ProgramListWindow(programs: program));
                    }
                  },
                  title: Text(
                    '',
                    style: const TextStyle(
                        color: Colors.white), // Main text with white text color
                  ),
                  trailing: GetBuilder<AudioController>(builder: (controller) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (program[0]['program_name'] ==
                                controller.programName &&
                            controller.isPlay)
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
                            size: Size(screenWidth / 10, screenHeight / 30),
                            waveAmplitude: 10,
                          ),
                        if (program[0]['program_name'] !=
                                controller.programName ||
                            !controller.isPlay)
                          Text(
                            '${program[0]['episode_time']}',
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.more_vert,
                            color: Colors
                                .white, // Three-dots icon with white color
                          ),
                        ),
                      ],
                    );
                  }));
            },
          ),
        ),
      ],
    );
  }

  Widget CalenderContainer() {
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              'Choose by Date',
              style: GoogleFonts.montserrat(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
            ),
          ),
        ),
        SizedBox(
          height: screenHeight / 50,
        ),
        Divider(
          color: Colors.white,
          thickness: 2.0,
        ),
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
          decoration: BoxDecoration(
              color: playAvatar, borderRadius: BorderRadius.circular(20)),
          child: TableCalendar(
              firstDay: DateTime.utc(2023, 1, 1),
              lastDay: DateTime.utc(2023, 12, 31),
              focusedDay: this._focusedDay,
              calendarFormat: this._calendarFormat,
              selectedDayPredicate: (day) {
                return isSameDay(this._selectedDay, day);
              },
              onFormatChanged: (format) {
                setState(() {
                  this._calendarFormat = format;
                });
              },
              onPageChanged: (focusedDay) {
                setState(() {
                  this._focusedDay = focusedDay;
                });
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  if (this.isPressed == 0) {
                    this.isPressed = 1;
                    fetchDataForSelectedDate(selectedDay!);
                    Fluttertoast.showToast(
                      msg:
                          "If you need choose by program press same date again ",
                      toastLength: Toast
                          .LENGTH_LONG, // Duration for which the toast is displayed
                      gravity: ToastGravity.BOTTOM, // Position of the toast
                      timeInSecForIosWeb:
                          1, // Duration for iOS (ignored on Android)
                      backgroundColor: const Color.fromARGB(
                          255, 222, 14, 14), // Background color of the toast
                      textColor: Colors.white, // Text color of the toast
                      fontSize: 16.0, // Font size of the toast message
                    );
                    print("pressed" + this.isPressed.toString());
                  }
                  if (_selectedDay == selectedDay) {
                    if (this.isPressed == 1) {
                      this.isPressed = 0;
                      fetchData();
                      Fluttertoast.showToast(
                        msg: "If you need choose by Date press a date ",
                        toastLength: Toast
                            .LENGTH_LONG, // Duration for which the toast is displayed
                        gravity: ToastGravity.BOTTOM, // Position of the toast
                        timeInSecForIosWeb:
                            1, // Duration for iOS (ignored on Android)
                        backgroundColor: const Color.fromARGB(
                            255, 222, 14, 14), // Background color of the toast
                        textColor: Colors.white, // Text color of the toast
                        fontSize: 10.0, // Font size of the toast message
                      );
                    }
                  }
                  this._selectedDay = selectedDay;
                });
              },
              calendarStyle: const CalendarStyle(
                disabledDecoration: BoxDecoration(),
                defaultTextStyle:
                    TextStyle(color: Colors.white), // White text color
                // Set the background color of the calendar
                outsideDaysVisible: false,
                // Hide non-visible days
                weekendTextStyle: TextStyle(
                    color: Colors.white), // White text color for weekends
              ),
              headerStyle: const HeaderStyle(
                  leftChevronIcon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors
                        .white, // Change the color of the left (back) arrow button
                  ),
                  rightChevronIcon: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors
                        .white, // Change the color of the right (forward) arrow button
                  ),
                  formatButtonTextStyle: TextStyle(color: Colors.white),
                  formatButtonDecoration:
                      BoxDecoration(color: Colors.transparent),
                  titleTextStyle: TextStyle(color: Colors.white)),
              daysOfWeekStyle: const DaysOfWeekStyle(
                weekdayStyle:
                    TextStyle(color: Colors.white), // Weekday text color
                weekendStyle: TextStyle(color: Colors.white24),
                // Weekend text color
              )),
        ),
      ],
    );
  }

  Future<void> fetchDataForSelectedDate(DateTime selectedDate) async {
    final formattedDate =
        "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
    final response =
        await http.get(Uri.parse('${appApi}api/programs/$formattedDate'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      // Check if 'programs_filtered' key exists and is not null
      if (data.containsKey('programs_filtered') &&
          data['programs_filtered'] != null) {
        final List<dynamic> programs = data['programs_filtered'];

        setState(() {
          // Map 'programs' to your desired format
          programsList = programs.map((program) {
            return [
              {
                'program_name': program['program_name'],
                'episode_time': program['episode_time'],
                // Add other fields as needed
              }
            ];
          }).toList();

          // Assuming you want to switch to the program list view
        });
      } else {
        // Handle the case where 'programs_filtered' is null
        print('Error: No programs found for the selected date.');
      }
    } else {
      throw Exception('Failed to load data for selected date');
    }
  }

  Map<String, List<Map<String, dynamic>>> groupBy(
      List<dynamic> iterable, String Function(Map<String, dynamic>) key) {
    final Map<String, List<Map<String, dynamic>>> result = {};

    for (final item in iterable) {
      final k = key(item);
      result[k] = result[k] ?? [];
      result[k]!.add(item);
    }

    return result;
  }
}
