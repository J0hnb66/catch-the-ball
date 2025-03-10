import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/services.dart';  // Added for LogicalKeyboardKey
import 'dart:math';  // Added for Random

// Main Menu Screen
class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catch the Ball Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GameScreen(),
                  ),
                );
              },
              child: Text('Start Game'),
            ),
            ElevatedButton(
              onPressed: () {
                // Close the app
                Navigator.pop(context);
              },
              child: Text('Quit'),
            ),
          ],
        ),
      ),
    );
  }
}

// Game Screen
class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: CatchTheBallGame(),
    );
  }
}

// Game Logic
class CatchTheBallGame extends FlameGame {
  late Player player;
  late Ball ball;
  late TextComponent scoreLabel;
  int score = 0;

  @override
  Future<void> onLoad() async {
    player = Player();
    ball = Ball();
    scoreLabel = TextComponent(text: 'Score: $score', position: Vector2(10, 10))
      ..anchor = Anchor.topLeft;

    add(player);
    add(ball);
    add(scoreLabel);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (player.toRect().overlaps(ball.toRect())) {
      score++;
      scoreLabel.text = 'Score: $score';
  
