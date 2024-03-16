import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nieproject/pages/auth/login.dart';
import 'package:nieproject/pages/player/player.dart';
import 'package:nieproject/services/providers/init_controllers.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  // runApp(const SoundControllingApp());
  runApp(
    DevicePreview(
      enabled: true,
      tools: [
        ...DevicePreview.defaultTools,

      ],
      builder: (context) => SoundControllingApp(),
    ),
  );
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



