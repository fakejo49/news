import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // <- penting untuk RawKeyEvent

class DinoRunPage extends StatefulWidget {
  const DinoRunPage({super.key});
  @override
  State<DinoRunPage> createState() => _DinoRunPageState();
}

class _DinoRunPageState extends State<DinoRunPage> {
  double dinoY = 1; // posisi (1 = ground)
  double time = 0;
  double height = 0;
  double initialHeight = 1;
  bool gameStarted = false;
  bool isJumping = false;

  double obstacleX = 1;
  Timer? gameTimer;

  void startGame() {
    gameStarted = true;
    gameTimer?.cancel();
    gameTimer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      time += 0.03;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        dinoY = initialHeight - height;
        obstacleX -= 0.02;
      });

      if (dinoY > 1) {
        dinoY = 1;
        isJumping = false;
      }
      if (obstacleX < -1.2) {
        obstacleX = 1.2;
      }

      // collision simple
      if (obstacleX < 0.1 && obstacleX > -0.1 && dinoY > 0.9) {
        timer.cancel();
        gameStarted = false;
        showGameOver();
      }
    });
  }

  void jump() {
    if (!isJumping) {
      isJumping = true;
      time = 0;
      initialHeight = dinoY;
    }
  }

  void resetGame() {
    gameTimer?.cancel();
    setState(() {
      dinoY = 1;
      obstacleX = 1;
      time = 0;
      isJumping = false;
      gameStarted = false;
    });
  }

  void showGameOver() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Game Over'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              resetGame();
            },
            child: const Text('Restart'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    gameTimer?.cancel();
    super.dispose();
  }

  // <-- Di sini kita gunakan RawKeyboardListener untuk mendeteksi spasi.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      body: RawKeyboardListener(
        focusNode: FocusNode(),
        autofocus: true,
        onKey: (RawKeyEvent event) {
          // Pastikan hanya merespon ketika tombol ditekan (down)
          if (event is RawKeyDownEvent) {
            // Cek apakah tombol spasi ditekan (LogicalKeyboardKey.space juga bisa dipakai)
            if (event.logicalKey == LogicalKeyboardKey.space) {
              if (!gameStarted) {
                startGame();
              } else {
                jump();
              }
            }
          }
        },
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            // tap layar untuk mulai / lompat (berguna di HP)
            if (!gameStarted) {
              startGame();
            } else {
              jump();
            }
          },
          child: Stack(
            children: [
              // Dino
              Align(
                alignment: Alignment(0, dinoY),
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.brown,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(child: Text('🦖', style: TextStyle(fontSize: 28))),
                ),
              ),

              // obstacle
              Align(
                alignment: Alignment(obstacleX, 1),
                child: Container(
                  width: 40,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.green[700],
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Center(child: Text('🌵', style: TextStyle(fontSize: 22))),
                ),
              ),

              // ground
              Align(
                alignment: const Alignment(0, 1),
                child: Container(height: 10, color: Colors.grey[800]),
              ),

              // info
              Positioned(top: 40, left: 20, child: Text(gameStarted ? 'Game running' : 'Tap / press SPACE to start')),
            ],
          ),
        ),
      ),
    );
  }
}
