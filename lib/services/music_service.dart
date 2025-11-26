import 'dart:io';

class Song {
  final String title;
  final String artist;
  final String url;

  Song({required this.title, required this.artist, required this.url});
}

class MusicService {
  // 🎧 ONLINE SONGS
  static List<Song> loadOnlineSongs() {
    return [
      Song(
        title: "Skyline",
        artist: "Luke Bergs",
        url: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3",
      ),
      Song(
        title: "Paradise",
        artist: "K-391",
        url: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3",
      ),
    ];
  }

  // 💾 LOCAL SONGS
  static Future<List<Song>> loadLocalSongs() async {
    final dir = Directory("D:/music");
    final files = dir.existsSync()
        ? dir.listSync().where((f) => f.path.endsWith(".mp3")).toList()
        : [];

    return files
        .map((f) => Song(
              title: f.uri.pathSegments.last.replaceAll(".mp3", ""),
              artist: "Local Artist",
              url: f.path,
            ))
        .toList();
  }
}
