import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:nieproject/enviroment/api.dart';
import 'package:nieproject/models/EpisodeProvider/program_episode.dart';

class AudioController extends GetxController {
  final AudioPlayer audioPlayer = AudioPlayer();
  double volume = 0.5; // Initial volume value
  bool isPlay = false;
  int language = 0;
  String audioStreamUrl = '';
  List<String> _playlist = [];
  int _currentIndex = 0;
  List<ProgramEpisode> programsList = [];
  String programName = "Program Title";
  String episodeName = "";
  double progress = 0;
  int programDuration = 0;
  bool error = false;
  String episodePlayedTime = "";

  Future<void> initAndPlayAudio(String url) async {
    audioStreamUrl = url;
    update();
    try {
      await audioPlayer.setUrl(url);
      if (!isPlay) {
        //added new here
        isPlay = true;
        error = false;
        update();
        await audioPlayer.play();

        update();
      } else {
        isPlay = true;
        error = false;
        await audioPlayer.pause();
        await audioPlayer.setVolume(1.0);
        await audioPlayer.play();
        update();
      }
    } catch (e) {
      isPlay = false;
      error = true;
      update();
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
    this.programDuration = program;
    audioPlayer.positionStream.listen((position) async {
      this.progress = position.inSeconds.toDouble() / program;
      if (progress == 1) {
        await pause();
      }
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

  // void _playNext() {
  //   if (_currentIndex < _playlist.length) {
  //     _currentIndex = (_currentIndex + 1) % _playlist.length;
  //     audioPlayer.setUrl(_playlist[_currentIndex]);
  //     audioPlayer.play();
  //     //change UI
  //     this.audioStreamUrl = _playlist[_currentIndex];
  //     ProgramEpisode? targetProgram = programsList.firstWhere((program) =>
  //         program.programFile == this.audioStreamUrl.replaceAll(appApi, ""));
  //     programName = targetProgram.programName;
  //     episodeName = targetProgram.episode;
  //     update();
  //     GetAudioServiceTime(convertTimeToSeconds(targetProgram.duration));
  //   }
  // }

  // void PlayPlayList(List<ProgramEpisode> list) async {
  //   // Update the programsList with the provided list
  //   this.programsList = list;

  //   // Filter the list to get only items with valid program_file
  //   _playlist =
  //       list.where((item) => item.programFile.isNotEmpty).map<String>((item) {
  //     // Get the program file URL and append ${appApi}
  //     return '${appApi}${item.programFile}';
  //   }).toList();

  //   // Set the initial audioStreamUrl to the first item in the playlist
  //   this.audioStreamUrl = _playlist[_currentIndex];

  //   // Find the target program based on the current audio stream URL
  //   ProgramEpisode? targetProgram = programsList.firstWhereOrNull((program) =>
  //       program.programFile == this.audioStreamUrl.replaceAll(appApi, ""));

  //   // Update programName and episodeName based on the target program
  //   programName = targetProgram?.programName ?? '';
  //   episodeName = targetProgram?.episode ?? '';
  //   episodePlayedTime = targetProgram?.episodeTime ?? '';

  //   update();

  //   // Get audio service time and update audio player URL
  //   GetAudioServiceTime(convertTimeToSeconds(targetProgram?.duration ?? ""));
  //   await audioPlayer.setUrl(_playlist[_currentIndex]);

  //   // Start playing the audio
  //   isPlay = true;
  //   await audioPlayer.play();

  //   // Listen to player state changes
  //   // audioPlayer.playerStateStream.listen((PlayerState state) {
  //   //   if (state.processingState == ProcessingState.completed) {

  //   //   }
  //   // });

  //   audioPlayer.positionStream.listen((position) async {
  //     this.progress = position.inSeconds.toDouble() /
  //         convertTimeToSeconds(targetProgram?.duration ?? "");
  //     if (progress == 1) {
  //       await pause();
  //       _playNext();
  //     }
  //   });
  // }

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

  play_function() async {
    isPlay = true;
    error = false;
    update();
    await audioPlayer.play();

    update();
  }

  Future<void> changeProgress(double value) async {
    await audioPlayer
        .seek(Duration(seconds: (value * programDuration).toInt()));
    update();
  }
}
