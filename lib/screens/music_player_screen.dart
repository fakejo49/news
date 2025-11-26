import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';
import '../services/music_service.dart';

class MusicPlayerScreen extends StatefulWidget {
  const MusicPlayerScreen({super.key});

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  final AudioPlayer _player = AudioPlayer();
  bool isPlaying = false;
  bool isLocal = false; // mode lokal atau online
  List<Song> songs = [];
  int currentIndex = 0;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();
    initPlayer();
  }

  Future<void> initPlayer() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.music());
    songs = isLocal
        ? await MusicService.loadLocalSongs()
        : MusicService.loadOnlineSongs();

    if (songs.isNotEmpty) {
      await _player.setUrl(songs[currentIndex].url);
    }

    _player.positionStream.listen((p) => setState(() => position = p));
    _player.durationStream.listen((d) => setState(() => duration = d ?? Duration.zero));
  }

  Future<void> playPause() async {
    if (isPlaying) {
      await _player.pause();
    } else {
      await _player.play();
    }
    setState(() => isPlaying = !isPlaying);
  }

  Future<void> nextSong() async {
    if (currentIndex < songs.length - 1) {
      currentIndex++;
      await _player.setUrl(songs[currentIndex].url);
      await _player.play();
      setState(() => isPlaying = true);
    }
  }

  Future<void> prevSong() async {
    if (currentIndex > 0) {
      currentIndex--;
      await _player.setUrl(songs[currentIndex].url);
      await _player.play();
      setState(() => isPlaying = true);
    }
  }

  Future<void> switchMode(bool local) async {
    await _player.stop();
    setState(() {
      isLocal = local;
      isPlaying = false;
      position = Duration.zero;
      duration = Duration.zero;
    });
    await initPlayer();
  }

  @override
  Widget build(BuildContext context) {
    final song = songs.isNotEmpty ? songs[currentIndex] : null;

    return Scaffold(
      backgroundColor: const Color(0xFF1B1E23),
      appBar: AppBar(
        title: const Text("FakeJo Music Player"),
        backgroundColor: const Color(0xFF292D32),
        actions: [
          PopupMenuButton<bool>(
            onSelected: (value) => switchMode(value),
            icon: const Icon(Icons.music_note),
            itemBuilder: (context) => [
              const PopupMenuItem(value: false, child: Text("Online Music")),
              const PopupMenuItem(value: true, child: Text("Local Music")),
            ],
          )
        ],
      ),
      body: songs.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset('assets/album_default.jpg',
                      width: 200, height: 200, fit: BoxFit.cover),
                ),
                const SizedBox(height: 20),
                Text(song?.title ?? "",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                Text(
                  song?.artist ?? "",
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 30),
                Slider(
                  value: position.inSeconds.toDouble(),
                  max: duration.inSeconds.toDouble() + 1,
                  onChanged: (v) async {
                    await _player.seek(Duration(seconds: v.toInt()));
                  },
                  activeColor: Colors.blueAccent,
                  inactiveColor: Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_formatTime(position),
                          style: const TextStyle(color: Colors.white)),
                      Text(_formatTime(duration),
                          style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: prevSong,
                      icon: const Icon(Icons.skip_previous, color: Colors.white),
                      iconSize: 40,
                    ),
                    IconButton(
                      onPressed: playPause,
                      icon: Icon(
                        isPlaying ? Icons.pause_circle : Icons.play_circle,
                        color: Colors.white,
                      ),
                      iconSize: 60,
                    ),
                    IconButton(
                      onPressed: nextSong,
                      icon: const Icon(Icons.skip_next, color: Colors.white),
                      iconSize: 40,
                    ),
                  ],
                ),
              ],
            ),
    );
  }

  String _formatTime(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }
}
