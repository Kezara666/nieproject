import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:nieproject/pages/player/player.dart';
import 'package:nieproject/services/providers/init_controllers.dart' as di;
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:awesome_notifications/awesome_notifications.dart';


@pragma("vm:entry-point")
void _onActionReceived(ReceivedAction action) {
  // Handle notification action
}

void main() async {

  // begin firebase
  await AwesomeNotifications().initialize(
    null, //'resource://drawable/res_app_icon',//
    [
      NotificationChannel(
          channelKey: 'call_channel',
          channelName: 'Call Channel',
          channelDescription: 'Notification tests as alerts',
          playSound: true,
          importance: NotificationImportance.High,
          defaultPrivacy: NotificationPrivacy.Private,
          defaultColor: Colors.deepPurple,
          ledColor: Colors.deepPurple,
          channelShowBadge: true,
          locked: true,
          defaultRingtoneType: DefaultRingtoneType.Ringtone)
    ],
  );
  FirebaseMessaging.onBackgroundMessage(backgroundHandeler);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsFlutterBinding.ensureInitialized();


  //end firebase

  HttpOverrides.global = MyHttpOverrides();  
  await di.init();

  runApp(const SoundControllingApp());
}

class SoundControllingApp extends StatelessWidget {
  const SoundControllingApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnAirScreen(),

      
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:device_preview/device_preview.dart';
// import 'package:nieproject/pages/auth/login.dart';
// import 'package:nieproject/pages/player/player.dart';
// import 'package:nieproject/services/providers/init_controllers.dart' as di;

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await di.init();
//   runApp(
//     DevicePreview(
//       enabled: !kReleaseMode, // Enable it only in debug builds
//       builder: (context) => const SoundControllingApp(), // Wrap your MaterialApp with DevicePreview
//     ),
//   );
// }

// class SoundControllingApp extends StatelessWidget {
//   const SoundControllingApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//   builder: DevicePreview.appBuilder, // Wrap your MaterialApp.builder
//   home: LoginPage(),
// );

//   }
// }

Future<void> backgroundHandeler(RemoteMessage message) async {
  String? title = message.notification!.title;
  String? body = message.notification!.body;

  AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 123,
          channelKey: 'call_channel',
          color: Colors.amber,
          title: title,
          body: body,
          category: NotificationCategory.Call,
          wakeUpScreen: true,
          fullScreenIntent: true,
          autoDismissible: false,
          backgroundColor: Colors.orange),
      actionButtons: [
        NotificationActionButton(
            key: "ACCEPT",
            label: "Accept Call",
            color: Colors.green,
            autoDismissible: true),
        NotificationActionButton(
            key: "REJECT",
            label: "Reject Call",
            color: Color.fromARGB(255, 210, 8, 8),
            autoDismissible: true)
      ]);
}
