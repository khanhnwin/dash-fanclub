import 'dart:math';
import 'package:flame/components.dart';

import './game.dart';
import './enemy.dart';

class EnemyManager extends Component with HasGameRef<FlappyDash> {
  late Timer _timer;
  final Random random = Random();

  EnemyManager() : super() {
    _timer = Timer(1, onTick: _spawnEnemy, repeat: true);
  }

  void _spawnEnemy() {
    Enemy enemy = Enemy(
      position: Vector2(gameRef.size.x,
          random.nextInt(gameRef.size.y.floor() - 70).toDouble()),
    );

    add(enemy);
  }

  void start() {
    _timer.start();
  }

  void stop() {
    _timer.stop();
  }

  @override
  void onMount() {
    super.onMount();
    _timer.start();
  }

  @override
  void onRemove() {
    super.onRemove();
    _timer.stop();
  }

  @override
  void update(double dt) {
    super.update(dt);
    _timer.update(dt);
  }
}
