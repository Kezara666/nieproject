// import 'package:flutter/material.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:nieproject/Viwes/slid_drawer.dart';

// class AudioPlayerPage extends StatefulWidget {
//   @override
//   _AudioPlayerPageState createState() => _AudioPlayerPageState();
// }

// class _AudioPlayerPageState extends State<AudioPlayerPage> {
//   final AudioPlayer audioPlayer = AudioPlayer();
//   bool isPlaying = false;
//   bool isLoading = false;

//   playAudioFromApi(String apiUrl) async {
//     setState(() {
//       isLoading = true;
//     });

//     print("playing");
//     await audioPlayer.setUrl(apiUrl);
//     await audioPlayer.play();

//     setState(() {
//       isPlaying = true;
//       isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Center(
//           child: Text('Nie Project'),
//         ),
//         iconTheme: IconThemeData(color: Colors.red),
//         actionsIconTheme: IconThemeData(color: Colors.red),
//         actions: [
//           IconButton.outlined(
//               onPressed: () {}, icon: Icon(Icons.widgets_rounded))
//         ],
//       ),
//       drawer: MyDrawer(),
//       body: Container(
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('assets/a.gif'), // Replace with your image path
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   IconButton(onPressed: () {}, icon: Icon(Icons.chat,color: Colors.white,)),
//                   const SizedBox(
//                       width: 100.0), // Adds space of 20 units between the icons
//                   IconButton(onPressed: () {}, icon: Icon(Icons.adb,color: Colors.white)),
//                 ],
//               ),
//               isLoading
//                   ? CircularProgressIndicator() // Show a loading indicator
//                   : IconButton(
//                       onPressed: () {
//                         playAudioFromApi('http://mediaserv30.live-streams.nl:8086/live');
//                       },
//                       icon: const Icon(Icons.play_circle_rounded,
//                           color: Colors.white, size: 150),
//                     ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     audioPlayer.dispose();
//     super.dispose();
//   }
// }
