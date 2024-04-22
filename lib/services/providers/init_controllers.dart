import 'package:get/get.dart';
import 'package:nieproject/models/ProgramProvider/Episodes_programs.dart';
import 'package:nieproject/models/EpisodeProvider/program_episode.dart';
import 'package:nieproject/pages/Menu/menu.dart';
import 'package:nieproject/pages/about.dart';
import 'package:nieproject/pages/auth/login.dart';
import 'package:nieproject/pages/chat/chat.dart';
import 'package:nieproject/pages/playList/program_list.dart';
import 'package:nieproject/pages/playListWithCalender/play-list-with-calender.dart';
import 'package:nieproject/pages/playRecoding/play-recoding.dart';
import 'package:nieproject/pages/player/player.dart';
import 'package:nieproject/pages/twoCirclePlayListWindow/two_circle_list_window.dart';
import 'package:nieproject/services/functions/AudioController/audio_controller.dart';
import 'package:nieproject/services/functions/ChatContoller/chat_controller.dart';
import 'package:nieproject/services/functions/userDetails/user_details.dart';
import 'package:nieproject/services/providers/language.dart';

//all controllers
Future<void> init() async{
  Get.lazyPut(()=>OnAirScreen());
  //Get.lazyPut(()=>const ProgramListWindow(programs: [],));
  Get.lazyPut(()=>const ProgramListCalenderWindow());
  Get.lazyPut(()=>const PlayRecodingWindow());
  Get.lazyPut(() => AudioController());
  Get.lazyPut(() => const ChatWindow());
  Get.lazyPut(() => ChatController());
  Get.lazyPut(() => const LoginPage());
  Get.lazyPut(() =>  UserDetails());
  Get.lazyPut(() =>  ProgramProvider());
  Get.lazyPut(() =>  TwoCirclePlayList());
  Get.lazyPut(() =>  MenuWindow());
  Get.lazyPut(() =>  EpisodeProvider());
  Get.lazyPut(() =>  AboutPage());
  Get.lazyPut(() =>  LanguageProvider ());
}

