import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:nieproject/enviroment/font.dart';
import 'package:nieproject/services/functions/AudioController/audio_controller.dart';
import 'package:nieproject/widgets/background-gradiant-button.dart';

Widget calenderWidowNavbar(double height, double width) {
  double iconSize = width / 15;
  bool shuffle = false;
  const playAvatar = Color.fromRGBO(117, 152, 200, 1);
  return GetBuilder<AudioController>(
    builder: (controller) {
      // Use the value from the controller to update the UI
      return Column(
    children: [
      LinearProgressIndicator(
        backgroundColor: playAvatar,
        value: controller.progress,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent),
      ),
      SizedBox(
        height: height / 50,
      ),
      Row(
        children: [
          SizedBox(width: width / 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text:  controller.programName,
                    style: TextStyle(
                      fontSize: width/30,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 218, 213, 213),
                    ),
                  ),
                  TextSpan(
                    text: ' \n\n' +translate("episode", language: language)+": " + controller.episodeName,
                    style: TextStyle(
                      fontSize: 12,
                      color: const Color.fromARGB(255, 162, 161, 161)
                          .withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ),
          ),
          GetBuilder<AudioController>(
          builder: (controller) {
            // Use the value from the controller to update the UI
            return BackGroundGradiantButtun(
            height: height,
          );
          },
        ),

          SizedBox(width: width / 10),
        ],
      ),
      SizedBox(
        height: height / 35,
      ),
    ],
  );
    },
  );
}
