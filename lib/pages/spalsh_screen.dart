// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:nieproject/pages/login.dart';

// import '../main.dart';
// // import 'login.dart';

// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // Simulate some initialization/loading process
//     Future.delayed(Duration(seconds: 3), () {
//       // Replace this with the code to navigate to the main screen
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => LoginPage()),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white, // Set your desired background color
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
//             children: [
//               Image.asset(
//                 'assets/logo.png', // Replace with your logo image path
//                 width: 150, // Set the desired width
//                 height: 150, // Set the desired height
//               ),
//               SizedBox(height: 20),
//               CircularProgressIndicator(), // Loading indicator
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Main Screen'),
//       ),
//       body: Center(
//         child: Text('Your App Content Here'),
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: SplashScreen(),
//   ));
// }
