import 'dart:ui';

import 'package:a45/game/flame/sbg_flame_game_nnn.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class SbgGlovesNnn extends SpriteComponent with HasGameRef<SbgFlameGameNnn> {
  SbgGlovesNnn() : super(priority: 3);
  @override
  Future<void> onLoad() async {
    sprite = await game.loadSprite('sbg_gloves_nnn.png');
    final ratio = sprite!.image.width / sprite!.image.height;
    size = Vector2(game.size.y * .2, game.size.y * .2 / ratio);
    anchor = Anchor.center;
    position = Vector2(
      game.size.x / 2,
      game.size.y * .75,
    );
    final paint = Paint()
      ..color = const Color.fromARGB(255, 210, 43, 43)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    add(PolygonHitbox([
      Vector2(0, 10),
      Vector2(0, 10),
      Vector2(10, 0),
      Vector2(size.x / 2, 40),
      Vector2(size.x - 10, 0),
      Vector2(size.x, 10),
      Vector2(size.x, size.y),
      Vector2(0, size.y),
    ])
      ..renderShape = true
      ..paint = paint);
    return super.onLoad();
  }
}
