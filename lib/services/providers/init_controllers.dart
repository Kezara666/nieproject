import 'package:get/get.dart';
import 'package:nieproject/pages/auth/login.dart';
import 'package:nieproject/pages/chat/call/call_page.dart';
import 'package:nieproject/pages/chat/chat.dart';
import 'package:nieproject/pages/playList/program_list.dart';
import 'package:nieproject/pages/playListWithCalender/play-list-with-calender.dart';
import 'package:nieproject/pages/playRecoding/play-recoding.dart';
import 'package:nieproject/pages/player/player.dart';
import 'package:nieproject/services/functions/AudioController/audio_controller.dart';
import 'package:nieproject/services/functions/ChatContoller/chat_controller.dart';
import 'package:nieproject/services/functions/userDetails/user_details.dart';

//all controllers
Future<void> init() async{
  Get.lazyPut(()=>OnAirScreen());
  Get.lazyPut(()=>const ProgramListWindow(programs: [],));
  Get.lazyPut(()=>const ProgramListCalenderWindow());
  Get.lazyPut(()=>const PlayRecodingWindow());
  Get.lazyPut(() => AudioController());
  Get.lazyPut(() => const ChatWindow());
  Get.lazyPut(() => ChatController());
  Get.lazyPut(() => const LoginPage());
  Get.lazyPut(() =>  UserDetails());
  Get.lazyPut(() => CallPage(callID: "call"));
  
  
}