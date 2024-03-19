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
    final paint = Paint()
      ..color = const Color.fromARGB(255, 255, 0, 0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    add(RectangleHitbox());

    return super.onLoad();
  }
}
