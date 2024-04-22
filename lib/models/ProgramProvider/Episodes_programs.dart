import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nieproject/enviroment/api.dart';

class ProgramProvider extends GetxController {
  List<Program> programs = List.empty();

  ProgramProvider() {
    fetchPrograms().then((value) {
      programs = value;
      update(); // Update the UI after fetching programs
    }).catchError((error) {
      print('Error fetching programs: $error');
    });
  }

  Future<List<Program>> fetchPrograms() async {
    final url = Uri.parse('${appApi}api/programs/list');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final List<dynamic> programsJson = jsonData['programs_list'];

        // Convert JSON data to a list of Program objects
        List<Program> programs =
            programsJson.map((json) => Program.fromJson(json)).toList();

        return programs;
      } else {
        throw Exception('Failed to load programs');
      }
    } catch (e) {
      throw Exception('Error fetching programs: $e');
    }
  }
}

class Episode {
  final int? id;
  final String? episode;
  final String? duration;
  final String? programFile;
  final String? episodeDate;
  final String? episodeTime;
  final String? programName;

  Episode({
    required this.id,
    required this.episode,
    required this.duration,
    required this.programFile,
    required this.episodeDate,
    required this.episodeTime,
    required this.programName,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      id: json['id'] as int?,
      episode: json['episode'] as String?,
      duration: json['duration'] as String?,
      programFile: json['program_file'] as String?,
      episodeDate: json['episode_date'] as String?,
      episodeTime: json['episode_time'] as String?, 
      programName: json['program_name'] as String?,
    );
  }
}

class Program {
  final int id;
  final String programName;
  final String programThumbnail;
  final List<Episode>? episodes;

  Program({
    required this.id,
    required this.programName,
    required this.programThumbnail,
    required this.episodes,
  });

  factory Program.fromJson(Map<String, dynamic> json) {
    return Program(
      id: json['id'] as int,
      programName: json['program_name'] as String,
      programThumbnail:
          json['program_thumbanail'] as String? ?? '', // Handle null value
      episodes: (json['episode'] as List? ?? [])
          .map((e) => Episode.fromJson(e ?? {}))
          .toList(), // Handle null value and convert to List<Episode>
    );
  }
}
