class ProgramData {
  final String programName;
  final String episode;
  final String episodeDate;
  final String episodeTime;
  final bool isVisible;
  final String programDirectory;
  final String programFile;
  final String duration;
  final String archiveId;

  ProgramData({
    required this.programName,
    required this.episode,
    required this.episodeDate,
    required this.episodeTime,
    required this.isVisible,
    required this.programDirectory,
    required this.programFile,
    required this.duration,
    required this.archiveId,
  });

  factory ProgramData.fromJson(Map<String, dynamic> json) {
    return ProgramData(
      programName: json['program_name'] ?? '',
      episode: json['episode'] ?? '',
      episodeDate: json['episode_date'] ?? '',
      episodeTime: json['episode_time'] ?? '',
      isVisible: json['is_visible'] ?? false,
      programDirectory: json['program_directory'] ?? '',
      programFile: json['program_file'] ?? '',
      duration: json['duration'] ?? '',
      archiveId: json['archive_id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'program_name': programName,
      'episode': episode,
      'episode_date': episodeDate,
      'episode_time': episodeTime,
      'is_visible': isVisible,
      'program_directory': programDirectory,
      'program_file': programFile,
      'duration': duration,
      'archive_id': archiveId,
    };
  }
}
