import 'package:a45/cewwedwq/wqdeqwxx/sbg_flame_game_nnn.dart';
import 'package:flame/components.dart';

class SbgFieldNnn extends SpriteComponent with HasGameRef<SbgFlameGameNnn> {
  @override
  Future<void> onLoad() async {
    sprite = await game.loadSprite('sbg_field_nnn.png');
    final ratio = sprite!.image.width / sprite!.image.height;
    size = Vector2(game.size.x, game.size.x / ratio);
    position.y = game.size.y - size.y * 1.44;
    return super.onLoad();
  }
}
