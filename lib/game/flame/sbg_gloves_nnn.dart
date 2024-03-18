import 'package:a45/game/flame/sbg_flame_game_nnn.dart';
import 'package:flame/components.dart';

class SbgGlovesNnn extends SpriteComponent with HasGameRef<SbgFlameGameNnn> {
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
    return super.onLoad();
  }
}
