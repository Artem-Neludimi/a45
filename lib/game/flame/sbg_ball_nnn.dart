import 'dart:math';

import 'package:a45/game/flame/sbg_flame_game_nnn.dart';
import 'package:flame/components.dart';

class SbgBallNnn extends SpriteComponent with HasGameRef<SbgFlameGameNnn> {
  SbgBallNnn() : super(priority: 1);

  Vector2 direction = Vector2(
    Random().nextDouble() * 600 - 300,
    100,
  );
  @override
  Future<void> onLoad() async {
    sprite = await game.loadSprite('sbg_ball_nnn.png');
    anchor = Anchor.center;
    size = Vector2(
      game.size.y * .13,
      game.size.y * .13,
    );
    position = Vector2(
      direction.x > 0
          ? Random().nextDouble() * game.size.x / 2
          : Random().nextDouble() * game.size.x / 2 + game.size.x / 2,
      0 - size.y / 2,
    );

    return super.onLoad();
  }

  @override
  void update(double dt) {
    _gravity(dt);
    _manageRemoval();
    super.update(dt);
  }

  void _gravity(double dt) {
    position += direction * dt;
    direction.y += 8;
    direction.x > 0 ? direction.x = max(0, direction.x - .1) : direction.x = min(0, direction.x + .1);
    angle += direction.x * dt / 100;
  }

  void _manageRemoval() {
    if (position.y > game.size.y) {
      game.remove(this);
    }
  }
}
