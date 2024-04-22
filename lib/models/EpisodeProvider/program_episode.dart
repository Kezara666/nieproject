import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nieproject/enviroment/api.dart';

class EpisodeProvider extends GetxController {
  List<ProgramEpisode> episodes = [];
  List<ProgramEpisode> episodesStatic = [];

  EpisodeProvider() {
    fetchEpisodes().then((value) {
      episodes = value;
      episodesStatic = episodes;
      update(); // Update the UI after fetching episodes
    }).catchError((error) {
      print('Error fetching episodes: $error');
    });
  }

  List<ProgramEpisode> filterEpisodesByDate(String date) {
    episodes =
        episodesStatic.where((episode) => episode.episodeDate == date).toList();
    return episodes;
  }

  Future<List<ProgramEpisode>> fetchEpisodes() async {
    final url = Uri.parse('${appApi}api/episode');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final List<dynamic> episodesJson = jsonData['episode_list'];

        // Convert JSON data to a list of ProgramEpisode objects
        List<ProgramEpisode> episodes =
            episodesJson.map((json) => ProgramEpisode.fromJson(json)).toList();
        episodes = episodes;
        episodesStatic = episodes;
        update();

        return episodes;
      } else {
        throw Exception('Failed to load episodes');
      }
    } catch (e) {
      throw Exception('Error fetching episodes: $e');
    }
  }
}

class ProgramEpisode {
  final int id;
  final String programName;
  final String programThumbnail;
  final String episode;
  final String duration;
  final String programFile;
  final String episodeDate;
  final String episodeTime;

  ProgramEpisode({
    required this.id,
    required this.programName,
    required this.programThumbnail,
    required this.episode,
    required this.duration,
    required this.programFile,
    required this.episodeDate,
    required this.episodeTime,
  });

  factory ProgramEpisode.fromJson(Map<String, dynamic> json) {
    return ProgramEpisode(
      id: json['id'],
      programName: json['program_name'],
      programThumbnail: json['program_thumbanail'],
      episode: json['episode'],
      duration: json['duration'],
      programFile: json['program_file'],
      episodeDate: json['episode_date'],
      episodeTime: json['episode_time'],
    );
  }

  static Future<List<ProgramEpisode>> fetchEpisodes() async {
    final response = await http.get(Uri.parse('${appApi}api/episode'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['episode_list'];
      return data.map((json) => ProgramEpisode.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
