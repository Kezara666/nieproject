import 'package:get/get.dart';
import 'package:nieproject/services/functions/userDetails/user_details.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:flutter/material.dart';

class CallPage extends StatelessWidget {
  
  CallPage({Key? key, required this.callID}) : super(key: key);
  final String callID;
  UserDetails userDetails = Get.find();

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: 944829607, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
      appSign: '6034d8f3a27f3ba937dbbbf050b1034a248469e58bb999bec09374896670d26a', // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
      userID: userDetails.loginUser,
      userName: userDetails.loginUser,
      callID: callID,
      // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall(),
    );
  }
}
