import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nieproject/enviroment/api.dart';
import 'package:nieproject/models/program.dart';
import 'package:nieproject/pages/playList/program_list.dart';
import 'package:nieproject/pages/playRecoding/play-recoding.dart';
import 'package:nieproject/pages/player/player.dart';
import 'package:nieproject/services/functions/AudioController/audio_controller.dart';
import 'package:nieproject/utils/colors.dart';
import 'package:nieproject/widgets/calender-widow-navbar.dart';
import 'package:nieproject/widgets/hamburger.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;
class ProgramListCalenderWindow extends StatefulWidget {
  const ProgramListCalenderWindow({Key? key});

  @override
  State<ProgramListCalenderWindow> createState() =>
      _ProgramListCalenderWindow();
}

class _ProgramListCalenderWindow extends State<ProgramListCalenderWindow> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  ProgramListWindow programListWindow=Get.find();
  AudioController audioController = Get.find();
  OnAirScreen onAirScreen =Get.find();
  PlayRecodingWindow playRecodingWindow = Get.find();

  List<dynamic> programsList = [];

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('${appApi}api/programs'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> programs = data['programs_list'];

      // Group items by program_name
      final groupedPrograms = groupBy(programs, (obj) => obj['program_name']);

      setState(() {
        programsList = groupedPrograms.values.toList();
      });
    } else {
      throw Exception('Failed to load data');
    }
  }
 @override
  void initState() {
    super.initState();
    // Call the async function to initialize and play audio when the widget is initialized
    fetchData();
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
                          Get.to(()=>onAirScreen);
                        },
                        icon: const Icon(Icons.arrow_back),
                        color: Colors.white),
                    Expanded(
                      child: Center(
                        child: Container(
                  height: screenHeight / 20,
                  width: screenWidth / 5,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(82, 134, 188, 1.0),
                        Color.fromRGBO(63, 193, 119, 1.0),
                      ],
                    ),
                  ),
                  child: Center(child: Text('NIE LOGO')),
                ),
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
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  decoration: BoxDecoration(
                      color: playAvatar, borderRadius: BorderRadius.circular(20)),
                  child: TableCalendar(
                      firstDay: DateTime.utc(2023, 1, 1),
                      lastDay: DateTime.utc(2023, 12, 31),
                      focusedDay: _focusedDay,
                      calendarFormat: _calendarFormat,
                      selectedDayPredicate: (day) {
                        return isSameDay(_selectedDay, day);
                      },
                      onFormatChanged: (format) {
                        setState(() {
                          _calendarFormat = format;
                        });
                      },
                      onPageChanged: (focusedDay) {
                        setState(() {
                          _focusedDay = focusedDay;
                        });
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          _selectedDay = selectedDay;
                
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
                          formatButtonTextStyle: TextStyle(
                            color: Colors.white
                          ),
                          formatButtonDecoration: BoxDecoration(
                            color: Colors.transparent
                          ),
                          titleTextStyle: TextStyle(color: Colors.white)),
                      daysOfWeekStyle: const DaysOfWeekStyle(
                        weekdayStyle:
                            TextStyle(color: Colors.white), // Weekday text color
                        weekendStyle: TextStyle(color: Colors.white24),
                        // Weekend text color
                      )),
                ),
                 if (_selectedDay != null)                 
                   Text('Selected Date: ${_selectedDay!.toLocal()}'),
                   
    
                SizedBox(
                  height: screenHeight / 60,
                ),
    
                Expanded(
                    child: ListView.builder(
                  itemCount: programsList.length, // Replace with your desired item count
                  itemBuilder: (context, index) {
                    // Simulated time
                    final program = programsList[index];
                    String time =
                        "${DateTime.now().hour}:${DateTime.now().minute}";
                    // Calculate the sum of 'duration' for each group                   
                    return ListTile(
                      leading: Text(
                        '${program[0]['program_name']}',
                        style: const TextStyle(
                            color: Colors
                                .white), // Number on the left corner with white text color
                      ),
                      onTap: () {
                        audioController.programName = program[0]['program_name'];
                        Get.to(() => ProgramListWindow(programs: program));
                      },
                      title: Text(
                      '',
                        style: const TextStyle(
                            color:
                                Colors.white), // Main text with white text color
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${program[0]['episode_time']}',
                            style: const TextStyle(
                                color:
                                    Colors.white), // Time with white text color
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
                      ),
                    );
                  },
                )
                ),
                calenderWidowNavbar(screenHeight, screenWidth),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Map<String, List<Map<String, dynamic>>> groupBy(List<dynamic> iterable, String Function(Map<String, dynamic>) key) {
    final Map<String, List<Map<String, dynamic>>> result = {};

    for (final item in iterable) {
      final k = key(item);
      result[k] = result[k] ?? [];
      result[k]!.add(item);
    }

    return result;
  }

}
