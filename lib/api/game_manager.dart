import '../ui/game/helpers/helpers.dart';

class GameManager {
  int score = 0;
  Direction? direction;

  increaseScore() {
    score += 1;
  }

  resetScore() {
    score = 0;
  }

  releaseControl() {
    direction = null;
  }

  setDirection(Direction dashDirection) {
    direction = dashDirection;
  }
}
