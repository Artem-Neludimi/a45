import 'package:a45/game/flame/sbg_flame_game_nnn.dart';
import 'package:flame/components.dart';

class SbgGoalNnn extends SpriteComponent with HasGameRef<SbgFlameGameNnn> {
  @override
  Future<void> onLoad() async {
    sprite = await game.loadSprite('sbg_goal_nnn.png');
    final ratio = sprite!.image.width / sprite!.image.height;
    size = Vector2(game.size.x, game.size.x / ratio);
    position.y = game.size.y - size.y;
    return super.onLoad();
  }
}
