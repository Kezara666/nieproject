
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:nieproject/services/functions/AudioController/audio_controller.dart';

class  BackGroundGradiantNextButtun extends StatefulWidget {
  final double height;

  const  BackGroundGradiantNextButtun({super.key, required this.height});

  @override
  State< BackGroundGradiantNextButtun> createState() =>
      _BackGroundGradiantButtunState();
}

class _BackGroundGradiantButtunState extends State< BackGroundGradiantNextButtun> {
  AudioController audioController = Get.find();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AudioController>(
      builder: (controller) {
        // Use the value from the controller to update the UI
        return IconButton(
          onPressed: () async {
            // try {
            //   if (audioController.isPlay) {
            //     await audioController.pause();
            //   } else {
            //     audioController.isPlay =true;
            //     await audioController
            //         .initAndPlayAudio(audioController.audioStreamUrl);
            //   }
            //   ;
            // } catch (e) {
            //   Fluttertoast.showToast(
            //     msg: e.toString(),
            //     toastLength: Toast
            //         .LENGTH_LONG, // Duration for which the toast is displayed
            //     gravity: ToastGravity.BOTTOM, // Position of the toast
            //     timeInSecForIosWeb: 1, // Duration for iOS (ignored on Android)
            //     backgroundColor: const Color.fromARGB(
            //         255, 222, 14, 14), // Background color of the toast
            //     textColor: Colors.white, // Text color of the toast
            //     fontSize: 16.0, // Font size of the toast message
            //   );
            // }
          },
          icon: ShaderMask(
            blendMode: BlendMode.srcATop,
            shaderCallback: (Rect bounds) {
              return const LinearGradient(
                colors: [
                  Color.fromARGB(255, 42, 84, 221),
                  Color.fromARGB(255, 9, 166, 77),
                  Color.fromARGB(255, 22, 173, 219),
                ], // Replace with your gradient colors
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                tileMode: TileMode.clamp,
              ).createShader(bounds);
            },
            child: Icon(
              Icons.skip_next,
              color:
                  Color.fromARGB(255, 9, 166, 77), // Color of the actual icon
              size: widget.height / 20, // Adjust the size of the icon as needed
            ),
          ),
        );
      },
    );
  }
}
