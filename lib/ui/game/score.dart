import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/text.dart';
import 'package:get_it/get_it.dart';

import '../../api/game_manager.dart';

GetIt getIt = GetIt.instance;

class ScoreDisplay extends TextComponent with HasGameRef {
  ScoreDisplay()
      : super(
          text: 'Score: 0',
          priority: 10,
          textRenderer: TextPaint(
            style: const TextStyle(
              fontSize: 24.0,
              package: 'GoogleFonts',
              fontFamily: 'Lobster',
            ),
          ),
        );

  @override
  void update(double dt) {
    int score = getIt<GameManager>().score;
    super.text = 'Score\n${score.toString()}';
  }

  Future<void> onLoad() async {
    super.onLoad();

    super.anchor = Anchor.topRight;
    super.x = gameRef.size.x - 15;
    super.y = 15.0;
  }
}
