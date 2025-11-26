import 'package:flutter/material.dart';

class SongControls extends StatelessWidget {
  final VoidCallback onPlayPause;
  final VoidCallback onNext;
  final VoidCallback onPrev;
  final bool isPlaying;

  const SongControls({
    super.key,
    required this.onPlayPause,
    required this.onNext,
    required this.onPrev,
    required this.isPlaying,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(onPressed: onPrev, icon: const Icon(Icons.skip_previous, size: 36)),
        IconButton(
          onPressed: onPlayPause,
          icon: Icon(isPlaying ? Icons.pause_circle : Icons.play_circle, size: 64),
        ),
        IconButton(onPressed: onNext, icon: const Icon(Icons.skip_next, size: 36)),
      ],
    );
  }
}
