import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nieproject/services/functions/AudioController/audio_controller.dart';

import 'package:nieproject/utils/colors.dart';
import 'package:nieproject/widgets/background-gradiant-button.dart';


Column playButtonWithDownBar(double height, double width, double value,
    String programTitle, String author, bool status) {
  

  AudioController audioController = Get.find();
  IconData buttonIcon = audioController.isPlay ? Icons.pause : Icons.play_arrow ;
  return Column(
    children: [
      LinearProgressIndicator(
        backgroundColor: playAvatar,
        value: value,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent),
      ),
      SizedBox(
        height: height / 30,
      ),
      Row(
        children: [
          SizedBox(width: width / 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: "Episode:"+programTitle,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 218, 213, 213),
                    ),
                  ),
                  TextSpan(
                    text: ' \n\n' + author,
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
            icon: buttonIcon,
          );
          },
        ),
          
          SizedBox(width: width / 10),
        ],
      ),
      SizedBox(
        height: height / 25,
      ),
    ],
  );
}
