
import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(PixelGame());

class PixelGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pixel Game',
      home: GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int pixelCount = 1;
  bool isBlue = true;
  bool isGameOver = false;
  Timer? colorTimer;

  @override
  void initState() {
    super.initState();
    startColorCycle();
  }

  void startColorCycle() {
    colorTimer = Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        isBlue = !isBlue;
      });
    });
  }

  void onTap() {
    if (isGameOver) return;

    setState(() {
      if (isBlue) {
        pixelCount++;
      } else {
        pixelCount--;
        if (pixelCount <= 0) {
          pixelCount = 0;
          isGameOver = true;
          colorTimer?.cancel();
        }
      }
    });
  }

  void restartGame() {
    setState(() {
      pixelCount = 1;
      isBlue = true;
      isGameOver = false;
    });
    startColorCycle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isBlue ? Colors.blue : Colors.red,
      body: GestureDetector(
        onTap: onTap,
        child: Center(
          child: isGameOver
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("GAME OVER",
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: restartGame,
                      child: Text("Restart"),
                    )
                  ],
                )
              : Container(
                  width: 20.0 * pixelCount,
                  height: 20.0 * pixelCount,
                  color: Colors.black,
                ),
        ),
      ),
    );
  }
}
