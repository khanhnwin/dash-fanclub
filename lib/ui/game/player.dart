import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:get_it/get_it.dart';

import './helpers/helpers.dart';
import '../../api/game_manager.dart';
import './game_over.dart';
import './game.dart';

GetIt getIt = GetIt.instance;

class Player extends SpriteComponent
    with HasGameRef<FlappyDash>, CollisionCallbacks {
  Player() : super(size: Vector2.all(75));

  bool hasCollided = false;
  Vector2 velocityVector = Vector2(0, 0);

  void move() {
    /*switch (direction) {
      case Direction.up:
        position.add(Vector2(0, -1 * velocity));
        break;
      case Direction.down:
        position.add(Vector2(0, velocity));
        break;
      case Direction.left:
        position.add(Vector2(-1 * velocity, 0));
        break;
      case Direction.right:
        position.add(Vector2(velocity, 0));
        break;
    }*/
  }

  @override
  void onCollision(
      Set<Vector2> intersectionPoints, PositionComponent other) async {
    super.onCollision(intersectionPoints, other);
    print('COLLISION!!');

    gameRef.activateGameOver();
  }

  @override
  void update(double dt) {
    Direction? direction = getIt<GameManager>().direction;

    if (direction == null) {
      velocityVector = Vector2(0, 0);
    } else if (direction == Direction.up) {
      if (position.y <= 0) return;

      velocityVector = Vector2(0, -200);
    } else if (direction == Direction.down) {
      if (position.y >= gameRef.size.y - size.y) return;

      velocityVector = Vector2(0, 200);
    }

    position.add(velocityVector * dt);
  }

  Future<void> onLoad() async {
    super.onLoad();
    add(CircleHitbox());
    sprite = await gameRef.loadSprite('game/dash.png');
  }
}
