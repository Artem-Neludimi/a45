import 'dart:math';

import 'package:a45/cewwedwq/sbg_settings_nnn.dart';
import 'package:a45/cewwedwq/wqdeqwxx/sbg_flame_game_nnn.dart';
import 'package:a45/xxllslsaa/sbg_goal_nnn.dart';
import 'package:a45/xxllslsaa/sbg_menu_nnn.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';

import '../../xxllslsaa/ewdwew/sbg_gloves_nnn.dart';

class SbgBallNnn extends SpriteComponent with HasGameRef<SbgFlameGameNnn>, CollisionCallbacks {
  SbgBallNnn() : super(priority: 1);

  Vector2 direction = Vector2(
    Random().nextDouble() * 600 - 300,
    100,
  );
  bool isCoin = false;
  @override
  Future<void> onLoad() async {
    isCoin = Random().nextDouble() > .9;
    if (isCoin) {
      sprite = await game.loadSprite('sbg_coin_nnn.png');
    } else {
      sprite = await game.loadSprite('sbg_ball_nnn.png');
    }
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
    add(CircleHitbox());

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

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    _audio(other);

    if (other is SbgGoalNnn && !isCoin) {
      game.lives.value--;
      game.remove(this);
    }
    if (other is SbgBarNnn) {
      direction.y = -400;
      direction.x = Random().nextDouble() * 600 - 300;
    }
    if (other is SbgBallNnn) {
      direction.y = Random().nextDouble() * 100 - 50;
      direction.x = (position.x - other.position.x) * 5;
    }
    if (other is SbgGlovesNnn) {
      _manageGloves(intersectionPoints, other);
    }
    super.onCollision(intersectionPoints, other);
  }

  bool isDelay = false;
  void _audio(PositionComponent other) async {
    if (!sbgSoundNotifierNnn.value) return;
    if (other is SbgGoalNnn) return;
    if (isDelay) return;
    isDelay = true;
    if (!isCoin) {
      FlameAudio.play('sbg_ball_nnn.mp3', volume: 10);
    }
    await Future.delayed(const Duration(milliseconds: 100));
    isDelay = false;
  }

  void _manageGloves(Set<Vector2> intersectionPoints, SbgGlovesNnn other) {
    if (isCoin) {
      _coinAudio();
      game.remove(this);
      sbgMoneyAddNnn(1);
      return;
    }
    final mid = intersectionPoints.reduce((a, b) => a + b) / intersectionPoints.length.toDouble();
    final rect = other.toRect();
    final isTop = mid.y - 15 < rect.top;
    if (isTop) {
      direction.y = -400;
      direction.x = (position.x - other.position.x) * 5;
    } else {
      direction.y = -100;
      direction.x = (position.x - other.position.x) * 5;
    }
  }

  void _coinAudio() {
    if (!sbgSoundNotifierNnn.value) return;
    FlameAudio.play('sbg_coin_nnn.mp3', volume: 3);
  }
}
