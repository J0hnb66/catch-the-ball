import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart'; // 🔥 For handling tap events
import 'dart:math';

void main() {
  runApp(const CatchTheBallApp());
}

class CatchTheBallApp extends StatelessWidget {
  const CatchTheBallApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Catch the Ball Game',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MainMenu(),
    );
  }
}

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Catch the Ball Game')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GameScreen()),
                );
              },
              child: const Text('Start Game'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Quit'),
            ),
          ],
        ),
      ),
    );
  }
}

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget(game: CatchTheBallGame());
  }
}

// Define a mixin if it's not already a part of Flame
mixin HasDraggableComponents on Component {
  void onDrag() {
    // Add drag logic here
  }
}

mixin HasCollidables on Component {
  void onCollide() {
    // Add collision logic here
  }
}

class CatchTheBallGame extends FlameGame
    with HasDraggableComponents, HasCollidables {
  late Player player;
  late Ball ball;
  late TextComponent scoreLabel;
  int score = 0;
  final Random random = Random();

  @override
  Future<void> onLoad() async {
    player =
        Player()
          ..position = size / 2
          ..size = Vector2(100, 20)
          ..anchor = Anchor.center;

    ball =
        Ball()
          ..position = Vector2(random.nextDouble() * size.x, 0)
          ..size = Vector2(30, 30)
          ..anchor = Anchor.center;

    scoreLabel = TextComponent(
      text: 'Score: $score',
      position: Vector2(10, 10),
      textRenderer: TextPaint(
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
    )..anchor = Anchor.topLeft;

    addAll([player, ball, scoreLabel]);
  }

  @override
  void update(double dt) {
    super.update(dt);

    ball.position.y += 200 * dt;

    if (player.toRect().overlaps(ball.toRect())) {
      score++;
      scoreLabel.text = 'Score: $score';
      ball.position = Vector2(random.nextDouble() * size.x, 0);
    }

    if (ball.position.y > size.y) {
      ball.position = Vector2(random.nextDouble() * size.x, 0);
    }
  }
}

class Player extends RectangleComponent with TapCallbacks {
  @override
  void onTapDown(TapDownEvent event) {
    position.x = event.localPosition.x - (size.x / 2);
  }
}

class Ball extends CircleComponent {}
