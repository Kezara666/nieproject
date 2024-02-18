import 'dart:ui';

import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:nieproject/enviroment/api.dart';

class AudioController extends GetxController {
  final AudioPlayer audioPlayer = AudioPlayer();
  double volume = 0.5; // Initial volume value
  bool isPlay = false;
  String audioStreamUrl = '';
  List<String> _playlist = [];
  int _currentIndex = 0;
  List<Map<String, dynamic>> programsList = [];
  String programName = "";
  String episodeName = "";
  double progress = 0;
  int programDuration = 0 ;

  Future<void> initAndPlayAudio(String url) async {

    //https convert into http
    url = url.replaceAll("https", "http");
    
    audioStreamUrl = url;
    update();
    try {
      await audioPlayer.setUrl(url);
      if (!isPlay) {
        await audioPlayer.play();
        isPlay = true;
        update();
      } else {
        isPlay = true;
        await audioPlayer.pause();
        await audioPlayer.play();
        update();
      }
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

  void updateVolume(double newValue) {
    volume = newValue;
    print(volume);
    update(); // Notify listeners of volume changes
  }

  Future<void> fetchData() async {
    try {
      final response = await http
          .get(Uri.parse('https://securityapp.realit.lk/nie/index.php'));

      if (response.statusCode == 200) {
        // Parse the response JSON or content
        final data = json.decode(response.body);

        // Assuming the response is a JSON object with a "stream_url" field
        final streamUrl = data['stream_url'];

        this.audioStreamUrl = streamUrl;
        update();
        initAndPlayAudio(audioStreamUrl);
      } else {
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void updateProgress(double progress) {
    // Update the progress value dynamically
    // this.progress = progress;
    // Fluttertoast.showToast(
    //   msg: this.progress.toString(),
    //   toastLength:
    //       Toast.LENGTH_LONG, // Duration for which the toast is displayed
    //   gravity: ToastGravity.BOTTOM, // Position of the toast
    //   timeInSecForIosWeb: 1, // Duration for iOS (ignored on Android)
    //   backgroundColor: const Color.fromARGB(
    //       255, 222, 14, 14), // Background color of the toast
    //   textColor: Colors.white, // Text color of the toast
    //   fontSize: 16.0, // Font size of the toast message
    // );
    update(); // Notify listeners
  }

  GetAudioServiceTime(int program) {
    audioPlayer.positionStream.listen((position) {
      this.progress = position.inSeconds.toDouble() / program;
      // Fluttertoast.showToast(
      //   msg: progress.toString(),
      //   toastLength:
      //       Toast.LENGTH_LONG, // Duration for which the toast is displayed
      //   gravity: ToastGravity.BOTTOM, // Position of the toast
      //   timeInSecForIosWeb: 1, // Duration for iOS (ignored on Android)
      //   backgroundColor: const Color.fromARGB(
      //       255, 222, 14, 14), // Background color of the toast
      //   textColor: Colors.white, // Text color of the toast
      //   fontSize: 16.0, // Font size of the toast message
      // );
      updateProgress(progress);

      // ... (your existing code)
    });
  }

  GetProgree() {
    return this.progress;
  }

  pause() async {
    await audioPlayer.pause();
    isPlay = false;
    update();
  }

  void _playNext() {
    _currentIndex = (_currentIndex + 1) % _playlist.length;
    audioPlayer.setUrl(_playlist[_currentIndex]);
    audioPlayer.play();
    //change UI
    this.audioStreamUrl = _playlist[_currentIndex];
    Map<String, dynamic>? targetProgram = programsList.firstWhere((program) =>
        program['program_file'] == this.audioStreamUrl.replaceAll(appApi, ""));
    programName = targetProgram["program_name"];
    episodeName = targetProgram["episode"];
    update();
    GetAudioServiceTime(targetProgram["duration"]);
  }

  void PlayPlayList(List<Map<String, dynamic>> list) async {
    this.programsList = list;

    _playlist = list
        .where((item) => item.keys
            .any((key) => key.contains('program_file') && item[key] is String))
        .map<String>((item) {
      // Get the string value associated with 'program_file' key and append ${appApi}
      return '${appApi}' + (item['program_file'] as String);
    }).toList();

    this.audioStreamUrl = _playlist[_currentIndex];
    Map<String, dynamic>? targetProgram = programsList.firstWhere((program) =>
        program['program_file'] == this.audioStreamUrl.replaceAll(appApi, ""));
    programName = targetProgram["program_name"];
    episodeName = targetProgram["episode"];
    update();
    GetAudioServiceTime(convertTimeToSeconds(targetProgram["duration"]));

    await audioPlayer.setUrl(_playlist[_currentIndex]);
    isPlay = true;
    await audioPlayer.play();

    audioPlayer.playerStateStream.listen((PlayerState state) {
      if (state.processingState == ProcessingState.completed) {
        _playNext();
      }
    });
  }

  int convertTimeToSeconds(String timeString) {
    List<String> timeComponents = timeString.split(':');

    if (timeComponents.length == 3) {
      int hours = int.parse(timeComponents[0]);
      int minutes = int.parse(timeComponents[1]);
      int seconds = int.parse(timeComponents[2]);

      int totalSeconds = hours * 3600 + minutes * 60 + seconds;
      return totalSeconds;
    } else {
      // Handle invalid time format
      print('Invalid time format');
      return 0;
    }
  }
}
