// // //import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // //import 'package:just_audio/just_audio.dart';
// // import 'package:nieproject/Viwes/audio_player.dart';

// // class LoginPage extends StatefulWidget {
// //   @override
// //   _LoginPageState createState() => _LoginPageState();
// // }

// // class _LoginPageState extends State<LoginPage> {
// //   final TextEditingController _usernameController = TextEditingController();
// //   final TextEditingController _passwordController = TextEditingController();
  

//   // void _login() {
//   //   // Check if username and password are valid (e.g., hardcoding for demonstration)
//   //   if (_usernameController.text == "user" &&
//   //       _passwordController.text == "password") {
//   //     Navigator.pushReplacement(
//   //       context,
//   //       MaterialPageRoute(builder: (context) => AudioPlayerPage()),
//   //     );
//   //   } else {
//   //     // Show an error message or dialog for invalid credentials
//   //     showDialog(
//   //       context: context,
//   //       builder: (context) => AlertDialog(
//   //         title: const Text('Login Failed'),
//   //         content: const Text('Invalid username or password.'),
//   //         actions: <Widget>[
//   //           TextButton(
//   //             child: const Text('OK'),
//   //             onPressed: () {
//   //               Navigator.of(context).pop();
//   //             },
//   //           ),
//   //         ],
//   //       ),
//   //     );
//   //   }
//   // }

// //   @override
// //   Widget build(BuildContext context) {
    
// //     return Scaffold(
// //       body: Container(
// //         // Set the background image
// //         decoration: const BoxDecoration(
// //           image: DecorationImage(
// //             image: AssetImage('assets/a.gif'), // Replace with your image path
// //             fit: BoxFit.cover,
// //           ),
// //         ),
// //         child: Center(
// //           child: Padding(
// //             padding: const EdgeInsets.all(20.0),
// //             child: Container(
// //               padding: const EdgeInsets.all(20),
// //               decoration: const BoxDecoration(color: Colors.white54,borderRadius: BorderRadius.all(Radius.circular(50))),
// //               height: MediaQuery.of(context).size.height/2,
// //               width: MediaQuery.of(context).size.width/1.3,
// //               child: Column(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: [
// //                   const Icon(Icons.radio,color: Colors.white),
// //                   const SizedBox(),
// //                   TextField(
// //                     controller: _usernameController,
// //                     decoration: const InputDecoration(
// //                         labelText: 'Username',
// //                         labelStyle: TextStyle(color: Colors.white)),
// //                   ),
// //                   const SizedBox(height: 50),
// //                   TextField(
// //                     controller: _passwordController,
// //                     obscureText: true,
// //                     decoration: const InputDecoration(
// //                         labelText: 'Password',
// //                         labelStyle: TextStyle(color: Colors.white)),
// //                   ),
// //                   const SizedBox(height: 50),
// //                   ElevatedButton(
// //                     onPressed: _login,
// //                     child: const Text('Login'),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }


// import 'package:flutter/material.dart';

// import 'audio_player.dart';

// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   bool _isVisible = false;
//   late AnimationController _animationController;

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 500),
//     );

//     // Delay the visibility of the login form
//     Future.delayed(Duration(milliseconds: 500), () {
//       setState(() {
//         _isVisible = true;
//       });
//       _animationController.forward(); // Start the animation
//     });
//   }

//   void _login() {
//     // Check if username and password are valid (e.g., hardcoding for demonstration)
//     if (_usernameController.text == "user" &&
//         _passwordController.text == "password") {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => AudioPlayerPage()),
//       );
//     } else {
//       // Show an error message or dialog for invalid credentials
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: const Text('Login Failed'),
//           content: const Text('Invalid username or password.'),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('OK'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         ),
//       );
//     }
//   }

//   @override
//   void dispose() {
//     _animationController.dispose(); // Dispose of the animation controller
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('assets/a.gif'),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: Center(
//           child: AnimatedOpacity(
//             opacity: _isVisible ? 1.0 : 0.0,
//             duration: Duration(milliseconds: 5),
//             child: SlideTransition(
//               position: Tween<Offset>(
//                 begin: Offset(0, -0.5),
//                 end: Offset.zero,
//               ).animate(CurvedAnimation(
//                 curve: Curves.easeInOut,
//                 parent: _animationController,
//               )),
//               child: Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Container(
//                   padding: const EdgeInsets.all(20),
//                   decoration: const BoxDecoration(
//                       color: Colors.white54,
//                       borderRadius: BorderRadius.all(Radius.circular(50))),
//                   height: MediaQuery.of(context).size.height / 2,
//                   width: MediaQuery.of(context).size.width / 1.3,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Icon(Icons.radio, color: Colors.white),
//                       const SizedBox(),
//                       TextField(
//                         controller: _usernameController,
//                         decoration: const InputDecoration(
//                             labelText: 'Username',
//                             labelStyle: TextStyle(color: Colors.white)),
//                       ),
//                       const SizedBox(height: 50),
//                       TextField(
//                         controller: _passwordController,
//                         obscureText: true,
//                         decoration: const InputDecoration(
//                             labelText: 'Password',
//                             labelStyle: TextStyle(color: Colors.white)),
//                       ),
//                       const SizedBox(height: 50),
//                       ElevatedButton(
//                         onPressed: _login,
//                         child: const Text('Login'),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
