import 'dart:ui';

import 'package:a45/game/flame/sbg_flame_game_nnn.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class SbgGoalNnn extends SpriteComponent with HasGameRef<SbgFlameGameNnn> {
  SbgGoalNnn() : super(priority: 2);
  @override
  Future<void> onLoad() async {
    sprite = await game.loadSprite('sbg_goal_nnn.png');
    final ratio = sprite!.image.width / sprite!.image.height;
    size = Vector2(game.size.x * .4, game.size.x * .4 / ratio);
    anchor = Anchor.center;
    position = Vector2(
      game.size.x / 2,
      game.size.y - size.y / 2,
    );
    add(RectangleHitbox(
      size: Vector2(size.x * .8, size.y * .6),
      anchor: const Anchor(-.12, -.66),
    )..renderShape = false);
    game.addAll([
      SbgBarNnn()
        ..radius = size.x * .03
        ..position = Vector2(
          position.x - size.x / 2 + size.x * .03,
          position.y - size.y / 2,
        ),
      SbgBarNnn()
        ..radius = size.x * .03
        ..position = Vector2(
          position.x + size.x / 2 - size.x * .1,
          position.y - size.y / 2,
        )
    ]);

    return super.onLoad();
  }
}

class SbgBarNnn extends CircleComponent {
  @override
  Future<void> onLoad() async {
    paint = Paint()..color = const Color.fromARGB(0, 0, 0, 0);
    add(CircleHitbox()..renderShape = false);
    return super.onLoad();
  }
}
