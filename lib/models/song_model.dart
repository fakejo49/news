class Song {
  final String title;
  final String path;
  final Duration duration;
  final String? albumArt;

  Song({
    required this.title,
    required this.path,
    required this.duration,
    this.albumArt,
  });
}
