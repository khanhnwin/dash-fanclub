import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';

import 'package:flame/collisions.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/text.dart';
import 'package:get_it/get_it.dart';

import 'helpers/helpers.dart';
import 'enemy.dart';
import './enemy_manager.dart';
import './crate.dart';
import './player.dart';
import './world.dart';
import './score.dart';
import '../../api/game_manager.dart';
import './game_over.dart';

GetIt getIt = GetIt.instance;

class FlappyDash extends FlameGame
    with KeyboardEvents, HasCollisionDetection, HasTappables {
  FlappyDash({super.children});
  late Player dash = Player();
  //late Crate myCrate;
  late World _world = World();
  EnemyManager enemyManager = EnemyManager();
  ScoreDisplay scoreDisplay = ScoreDisplay();
  StartGameButton startButton = StartGameButton();
  PauseGameButton pauseButton = PauseGameButton();
  late RestartGameButton restartButton;
  late GameOver gameOver;

  @override
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    if (event is RawKeyUpEvent) {
      getIt<GameManager>().releaseControl();
    }

    final bool isKeyDown = event is RawKeyDownEvent;

    if (isKeyDown) {
      if (keysPressed.contains(LogicalKeyboardKey.arrowDown)) {
        print('arrow down!');
        getIt<GameManager>().setDirection(Direction.down);
      }
      if (keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
        print('arrow up!');
        getIt<GameManager>().setDirection(Direction.up);
      }
    }

    return KeyEventResult.handled;
  }

  @override
  Future<void> onLoad() async {
    // Add Game components that should appear in the game
    //myCrate = Crate();
    await add(_world);
    await add(dash);

    await add(scoreDisplay);

    /*add(
      TextComponent(
        text: 'Score: $_score',
        textRenderer: textPaint,
        priority: 10,
      )
        ..anchor = Anchor.topCenter
        ..x = _world.size.x * 5 / 6
        ..y = 15.0,
    );*/
    //await add(Enemy(position: Vector2(size.x, size.y - 70)));

    //await add(Enemy(position: Vector2(size.x, (size.y / 3) - 5)));
    add(enemyManager);

    //await add(myCrate);
    dash.position = Vector2(_world.size.x / 8, _world.size.y / 3);
    //myCrate.position = Vector2(50, this.size.y - 100);

    dash.add(startButton);
    startButton.position = Vector2(75, 10);
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
  }

  void addPauseButton() {
    add(pauseButton);
  }

  void removePauseButton() {
    pauseButton.removeFromParent();
  }

  void addStartButton() {
    add(startButton);
  }

  void removeStartButton() {
    startButton.removeFromParent();
  }

  void activateGameOver() {
    pauseButton.removeFromParent();

    getIt<GameManager>().setGameOver(true);
    //gameOver = GameOver();
    //add(gameOver);
    overlays.add('GameOver');

    restartButton = RestartGameButton();
    add(restartButton);

    enemyManager.stop();
  }

  void resetGame() {
    print('reset game');

    if (getIt<GameManager>().gameOver == false) {
      return;
    }

    getIt<GameManager>().resetScore();
    getIt<GameManager>().setGameOver(false);
    dash.position = Vector2(_world.size.x / 8, _world.size.y / 3);

    overlays.remove('GameOver');

    children.whereType<Enemy>().forEach((enemy) {
      enemy.removeFromParent();
    });

    pauseButton = PauseGameButton();
    add(pauseButton);

    enemyManager.start();

    //resumeEngine();
  }

  @override
  Color backgroundColor() => Color.fromARGB(255, 158, 230, 244);
}

/*main() {
  FlappyDash myGame = FlappyDash();

  runApp(
    GameWidget(
      game: myGame,
    ),
  );
}*/

class Game extends StatelessWidget {
  Game({super.key});

  final game = FlappyDash();

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        color: Colors.deepPurple,
      ),
      Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            SizedBox(
              height: 350,
              child: GameWidget(
                game: game,
                overlayBuilderMap: {
                  'GameOver': (BuildContext context, FlappyDash game) {
                    return const Center(
                      heightFactor: 5,
                      child: Text(
                        'GAME OVER',
                        style: TextStyle(
                            backgroundColor: Colors.red,
                            color: Colors.white,
                            fontSize: 42,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 12),
                      ),
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 25, 15, 0),
              child: Column(
                children: [
                  GestureDetector(
                    onTapDown: (TapDownDetails details) =>
                        {getIt<GameManager>().setDirection(Direction.up)},
                    onTapUp: (TapUpDetails) =>
                        {getIt<GameManager>().releaseControl()},
                    child: Container(
                      height: 100,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: const Icon(Icons.arrow_drop_up,
                          size: 48, color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTapDown: (TapDownDetails details) =>
                        {getIt<GameManager>().setDirection(Direction.down)},
                    onTapUp: (TapUpDetails details) =>
                        {getIt<GameManager>().releaseControl()},
                    child: Container(
                      height: 100,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Icon(Icons.arrow_drop_down,
                          size: 48, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}

class StartGameButton extends SpriteComponent
    with HasGameRef<FlappyDash>, Tappable {
  StartGameButton()
      : super(
          size: Vector2(150, 76),
          priority: 25,
        );

  @override
  bool onTapDown(TapDownInfo info) {
    gameRef.resumeEngine();

    gameRef.addPauseButton();

    removeFromParent();

    return true;
  }

  @override
  void onMount() {
    // TODO: implement onMount
    super.onMount();
    gameRef.pauseEngine();
  }

  @override
  Future<void>? onLoad() async {
    super.onLoad();

    sprite = await gameRef.loadSprite('game/start_button.png');

    //anchor = Anchor.center;
  }
}

class PauseGameButton extends SpriteComponent
    with HasGameRef<FlappyDash>, Tappable {
  PauseGameButton()
      : super(size: Vector2(75, 38), priority: 25, position: Vector2(15, 15));

  @override
  bool onTapDown(TapDownInfo info) {
    print('PRINT PAUSE');

    gameRef.addStartButton();

    gameRef.startButton.position = Vector2(120, 120);

    removeFromParent();

    //gameRef.pauseEngine();

    return true;
  }

  @override
  Future<void>? onLoad() async {
    super.onLoad();

    sprite = await gameRef.loadSprite('game/pause_button.png');
  }
}

class RestartGameButton extends SpriteComponent
    with HasGameRef<FlappyDash>, Tappable {
  RestartGameButton()
      : super(
            size: Vector2(150, 76), priority: 25, position: Vector2(120, 160));

  @override
  bool onTapDown(TapDownInfo info) {
    gameRef.resetGame();

    print('CLICK RESTART');

    //gameRef.resumeEngine();

    removeFromParent();

    return true;
  }

  @override
  void onMount() {
    // TODO: implement onMount
    super.onMount();
  }

  @override
  Future<void>? onLoad() async {
    super.onLoad();

    sprite = await gameRef.loadSprite('game/restart_button.png');
  }
}
