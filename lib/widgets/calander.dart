// //list of proframs
//   import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:nieproject/enviroment/font.dart';
// import 'package:nieproject/utils/colors.dart';
// import 'package:syncfusion_flutter_calendar/calendar.dart';

// Widget ContainerCalender(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;
//     var _episodes;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         if (screenHeight > 700)
//           Column(
//             children: [
//               SizedBox(
//                 height: screenHeight / 60,
//               ),
//               Center(
//                   child: Text(
//                 translate('programName', language: language),
//                 style: TextStyle(
//                     fontFamily: 'SinhalaFont', // Use the Sinhala font family
//                     fontSize: 16,
//                     color: Colors.white),
//               )),
//               SizedBox(
//                 height: screenHeight / 80,
//               ),
//             ],
//           ),
//         _episodes.length > 0
//             ? ListEpisodes(screenWidth, screenHeight)
//             : LinearProgressIndicator()
//       ],
//     );
//   }
  
  

//   // Future<void> fetchDataForSelectedDate(DateTime selectedDate) async {
//   //   final formattedDate =
//   //       "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";

//   //   // Flatten the list of lists into a single list of programs
//   //   final List<dynamic> allPrograms =
//   //       programsList.expand((element) => element).toList();

//   //   //print('All Programs: $allPrograms');
//   //   print('Formatted Date: $formattedDate');

//   //   // Filter programs based on the selected date
//   //   final filteredPrograms = allPrograms.where((program) {
//   //     // Parse the episode date string into a DateTime object
//   //     final episodeDate = DateTime.parse(program['episode_date']);
//   //     // Convert the selected date into a DateTime object for comparison
//   //     final selectedDateTime = DateTime(
//   //       selectedDate.year,
//   //       selectedDate.month,
//   //       selectedDate.day,
//   //     );
//   //     print('Episode Date: $episodeDate');
//   //     print('Formatted Date: $selectedDateTime');
//   //     // Check if the episode date matches the selected date
//   //     return episodeDate.isAtSameMomentAs(selectedDateTime);
//   //   }).toList();

//   //   print('Filtered Programs: $filteredPrograms');
//   //   print('Filtered Programs: $filteredPrograms');
//   //   if (filteredPrograms.isNotEmpty) {
//   //     setState(() {
//   //       programsList = [filteredPrograms];

//   //       // Wrap filtered programs in a list to match the structure
//   //       isPressed = 1;
//   //     });
//   //   } else {
//   //     setState(() {
//   //       isPressed = 0;
//   //     });
//   //     Fluttertoast.showToast(
//   //       msg: "This Day No Any Recodings",
//   //       toastLength: Toast.LENGTH_LONG,
//   //       gravity: ToastGravity.BOTTOM,
//   //       timeInSecForIosWeb: 1,
//   //       backgroundColor: const Color.fromARGB(255, 222, 14, 14),
//   //       textColor: Colors.white,
//   //       fontSize: 10.0,
//   //     );
//   //   }
//   // }

//   // Map<String, List<Map<String, dynamic>>> groupBy(
//   //     List<dynamic> iterable, String Function(Map<String, dynamic>) key) {
//   //   final Map<String, List<Map<String, dynamic>>> result = {};

//   //   for (final item in iterable) {
//   //     final k = key(item);
//   //     result[k] = result[k] ?? [];
//   //     result[k]!.add(item);
//   //   }

//   //   return result;
//   // }

//   Container ListEpisodes(double screenWidth, double screenHeight) {
//     return Container(
//       height: 200,
//       child: ListView.builder(
//         itemCount: _episodes.length,
//         itemBuilder: (context, index) {
//           String time = "${DateTime.now().hour}:${DateTime.now().minute}";

//           return Padding(
//             padding: EdgeInsets.only(left: screenWidth / 20),
//             child: ListTile(
//               onTap: () async {
//                 /////////////////////////////////////play episode
//                 onTapMethod(_episodes[index]);
//                 Fluttertoast.showToast(
//                   msg: audioController.isPlay ? "Start Playing" : "Pause Audio",
//                   toastLength: Toast.LENGTH_LONG,
//                   gravity: ToastGravity.BOTTOM,
//                   timeInSecForIosWeb: 1,
//                   backgroundColor: const Color.fromARGB(255, 222, 14, 14),
//                   textColor: Colors.white,
//                   fontSize: 16.0,
//                 );
//               },
//               leading: Text(
//                 '${index + 1}',
//                 style: GoogleFonts.montserrat(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               title: Text(
//                 'Episode: ' +
//                     (_episodes[index].episode != null &&
//                             _episodes[index].episode!.isNotEmpty
//                         ? _episodes[index].episode!
//                         : "No episodes"),
//                 style: GoogleFonts.montserrat(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                   fontSize: screenHeight / 50,
//                 ),
//               ),
//               trailing: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   SizedBox(
//                     height: screenWidth / 60,
//                   ),
//                   if (_episodes[index].episode == audioController.episodeName &&
//                       audioController.isPlay &&
//                       audioController.programName ==
//                           _episodes[index].programName)
//                     AudioWave(
//                       height: 32,
//                       width: 32,
//                       spacing: 2.5,
//                       animationLoop: 9999,
//                       bars: [
//                         AudioWaveBar(
//                             heightFactor: 0.7,
//                             color: Colors.lightBlueAccent), // Light blue bar
//                         AudioWaveBar(
//                             heightFactor: 0.8, color: Colors.blue), // Blue bar
//                         AudioWaveBar(
//                             heightFactor: 1,
//                             color: Color.fromARGB(
//                                 255, 9, 117, 205)), // Cyan-like bar
//                         AudioWaveBar(
//                             heightFactor: 0.9,
//                             color: Colors
//                                 .blue), // Specify the color here, e.g., same as the second bar
//                       ],
//                     ),
//                   if (_episodes[index].episode != audioController.episodeName ||
//                       !audioController.isPlay)
//                     Text(
//                       RemoveSeconds(_episodes[index].duration),
//                       style: GoogleFonts.montserrat(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   if (_episodes[index].episode == audioController.episodeName &&
//                       audioController.programName !=
//                           _episodes[index].programName)
//                     Text(
//                       RemoveSeconds(_episodes[index].duration),
//                       style: GoogleFonts.montserrat(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   IconButton(
//                     onPressed: () {
//                       showPopupMenuDownload(
//                           context, screenHeight, _episodes[index]);
//                     },
//                     icon: Icon(
//                       Icons.more_vert,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   void showPopupMenuDownload(
//       BuildContext context, double screenHeight, dynamic listObject) async {
//     final RenderBox overlay =
//         Overlay.of(context)!.context.findRenderObject() as RenderBox;
//     final Offset offset = Offset(overlay.size.width - 50,
//         screenHeight / 1.5); // Adjust the values based on your UI
//     final result = await showMenu(
//       context: context,
//       position: RelativeRect.fromLTRB(offset.dx, offset.dy, 0, 0),
//       items: [
//         PopupMenuItem<String>(
//           value: 'Open',
//           child: const Text('Open'),
//         ),
//         PopupMenuItem<String>(
//           value: 'Download',
//           child: const Text('Download'),
//         ),
//       ],
//     );

//     // Handle the selected option
//     if (result != null) {
//       handleMenuOption(result, listObject);
//     }
//   }

//   Future<void> pause() async {
//     try {
//       await audioController.pause();
//       audioController.isPlay = false;
//       await audioController.audioPlayer.pause();
//     } catch (e) {
//       print('Error playing audio: $e');

//       Fluttertoast.showToast(
//         msg: e.toString(),
//         toastLength:
//             Toast.LENGTH_LONG, // Duration for which the toast is displayed
//         gravity: ToastGravity.BOTTOM, // Position of the toast
//         timeInSecForIosWeb: 1, // Duration for iOS (ignored on Android)
//         backgroundColor: const Color.fromARGB(
//             255, 222, 14, 14), // Background color of the toast
//         textColor: Colors.white, // Text color of the toast
//         fontSize: 16.0, // Font size of the toast message
//       );
//     }
//   }

//   Future<void> onTapMethod(ProgramEpisode program) async {
//     if (audioController.isPlay) {
//       this.audioController.isPlay = false;

//       await pause();
//     } else if (!audioController.isPlay) {
//       this.audioController.isPlay = true;

//       initAndPlayAudio("${appApi}${program.programFile}");
//     }

//     // Set the program name and episode name in the audio controller
//     audioController.programName = program.programName ?? '';
//     audioController.episodeName = program.episode ?? '';
//   }
// }

// Future<void> initAndPlayAudio(String url) async {
//   AudioController audioController = Get.find();
//   try {
//     await audioController.initAndPlayAudio(url);
//   } catch (e) {
//     print('Error playing audio: $e');

//     Fluttertoast.showToast(
//       msg: e.toString(),
//       toastLength:
//           Toast.LENGTH_LONG, // Duration for which the toast is displayed
//       gravity: ToastGravity.BOTTOM, // Position of the toast
//       timeInSecForIosWeb: 1, // Duration for iOS (ignored on Android)
//       backgroundColor: const Color.fromARGB(
//           255, 222, 14, 14), // Background color of the toast
//       textColor: Colors.white, // Text color of the toast
//       fontSize: 16.0, // Font size of the toast message
//     );
//   }
// }