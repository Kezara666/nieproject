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
                  radius: screenHeight /
                      40, // Increase the radius to make it larger
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
          height: screenHeight / 100,
        ),
      if (this.isPressed == 0)
        SizedBox(width: screenWidth * 0.99, child: CalenderContainer()),
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
          decoration: const BoxDecoration(color: Color.fromRGBO(3, 20, 48, 1)),
          child: SafeArea(
            child: Column(
              children: children2,
            ),
          ),
        ),
      ),
    );
  }


//list of proframs
  Widget ContainerCalender(double isPressed) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (screenHeight > 700)
          Column(
            children: [
              SizedBox(
                height: screenHeight / 60,
              ),
              Center(
                child: Text(
                  'Choose by Program',
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight / 80,
              ),
            ],
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

              return Padding(
                  padding: EdgeInsets.only(left: screenWidth / 10),
                  child: ListTitlesOfProgramList(
                      program, isPressed, screenWidth, screenHeight),
                );
            },
          ),
        ),
      ],
    );
  }

  ListTile ListTitlesOfProgramList(
      program, double isPressed, double screenWidth, double screenHeight) {
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
          } else {
            Get.to(() => ProgramListWindow(
                programs: program.cast<Map<String, dynamic>>()));
          }
        },
        title: Text(
          ' ',
          style: const TextStyle(
              color: Colors.white), // Main text with white text color
        ),
        trailing: GetBuilder<AudioController>(builder: (controller) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (program[0]['program_name'] == controller.programName &&
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
              if (program[0]['program_name'] != controller.programName ||
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
                  color: Colors.white, // Three-dots icon with white color
                ),
              ),
            ],
          );
        }));
  }

//down set calender 
  Widget CalenderContainer() {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Center(
          child: Text(
            'Choose by Date',
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
          padding: screenHeight>700? EdgeInsets.all(screenWidth / 20):EdgeInsets.all(0),
          child: Container(
            //margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
            decoration: BoxDecoration(
                color: playAvatar, borderRadius: BorderRadius.circular(20)),
            child: TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: DateTime.now(),
              calendarStyle: CalendarStyle(
                disabledDecoration: BoxDecoration(),
                defaultTextStyle: TextStyle(color: Colors.white),
                outsideDaysVisible: false,
                weekendTextStyle: TextStyle(color: Colors.white),
              ),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  if (isPressed == 0) {
                    isPressed = 1;
                    fetchDataForSelectedDate(selectedDay);
                    // Fluttertoast.showToast(
                    //   msg: "If you need choose by program press same date again ",
                    //   toastLength: Toast.LENGTH_LONG,
                    //   gravity: ToastGravity.BOTTOM,
                    //   timeInSecForIosWeb: 1,
                    //   backgroundColor: const Color.fromARGB(255, 222, 14, 14),
                    //   textColor: Colors.white,
                    //   fontSize: 16.0,
                    // );
                    print("pressed" + isPressed.toString());
                  }
                  if (_selectedDay == selectedDay) {
                    if (isPressed == 1) {
                      isPressed = 0;
                      fetchData();
                      Fluttertoast.showToast(
                        msg: "If you need choose by Date press a date ",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: const Color.fromARGB(255, 222, 14, 14),
                        textColor: Colors.white,
                        fontSize: 10.0,
                      );
                    }
                  }
                  _selectedDay = selectedDay;
                });
              },
              headerStyle: HeaderStyle(
                leftChevronIcon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: screenWidth / 20,
                ),
                rightChevronIcon: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: screenWidth / 20,
                ),
                formatButtonTextStyle: TextStyle(color: Colors.white),
                formatButtonDecoration:
                    BoxDecoration(color: Colors.transparent),
                titleTextStyle: TextStyle(color: Colors.white),
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: TextStyle(color: Colors.white),
                weekendStyle: TextStyle(color: Colors.white24),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> fetchDataForSelectedDate(DateTime selectedDate) async {
    final formattedDate =
        "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";

    // Flatten the list of lists into a single list of programs
    final List<dynamic> allPrograms =
        programsList.expand((element) => element).toList();

    //print('All Programs: $allPrograms');
    print('Formatted Date: $formattedDate');

    // Filter programs based on the selected date
    final filteredPrograms = allPrograms.where((program) {
      // Parse the episode date string into a DateTime object
      final episodeDate = DateTime.parse(program['episode_date']);
      // Convert the selected date into a DateTime object for comparison
      final selectedDateTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
      );
      print('Episode Date: $episodeDate');
      print('Formatted Date: $selectedDateTime');
      // Check if the episode date matches the selected date
      return episodeDate.isAtSameMomentAs(selectedDateTime);
    }).toList();

    print('Filtered Programs: $filteredPrograms');
    print('Filtered Programs: $filteredPrograms');
    if (filteredPrograms.isNotEmpty) {
      setState(() {
        programsList = [filteredPrograms];

        // Wrap filtered programs in a list to match the structure
        isPressed = 1;
      });
    } else {
      setState(() {
        isPressed = 0;
      });
      Fluttertoast.showToast(
        msg: "This Day No Any Recodings",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: const Color.fromARGB(255, 222, 14, 14),
        textColor: Colors.white,
        fontSize: 10.0,
      );
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
