import 'package:dash_fanclub_app/ui/game/game.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/text.dart';
import 'package:get_it/get_it.dart';

import '../../api/game_manager.dart';

GetIt getIt = GetIt.instance;

class GameOver extends TextComponent with HasGameRef<FlappyDash> {
  GameOver()
      : super(
          text: 'GAME OVER',
          priority: 10,
          textRenderer: TextPaint(
            style: const TextStyle(
              backgroundColor: Color.fromARGB(255, 199, 13, 0),
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.w600,
              letterSpacing: 24,
              package: 'GoogleFonts',
              fontFamily: 'Lobster',
            ),
          ),
        );

  @override
  void onMount() {
    // TODO: implement onMount
    super.onMount();

    //RestartGameButton restartButton = RestartGameButton();
    //gameRef.add(restartButton);

    //gameRef.pauseEngine();
  }

  void clear() {
    removeFromParent();

    print('CLEAR!');
  }

  @override
  void onRemove() {
    // TODO: implement onRemove
    super.onRemove();
  }

  @override
  void update(double dt) {}

  Future<void> onLoad() async {
    super.onLoad();

    x = 5;
    y = 110;
    priority = 25;
  }
}
