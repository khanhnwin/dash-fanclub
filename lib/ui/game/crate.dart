import 'package:flame/components.dart';

class Crate extends SpriteComponent {
  Crate() : super(size: Vector2.all(30), position: Vector2(0, 50));

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('game/crate.png');
  }

  void move(String direction) {
    switch (direction) {
      case 'up':
        position.add(Vector2(0, -10));
        break;
      case 'down':
        position.add(Vector2(0, 10));
        break;
      case 'left':
        position.add(Vector2(-10, 0));
        break;
      case 'right':
        position.add(Vector2(10, 0));
        break;
    }
  }
}
