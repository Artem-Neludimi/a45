import 'dart:ui';

import 'package:a45/game/flame/sbg_ball_nnn.dart';
import 'package:a45/game/flame/sbg_gloves_nnn.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';

import 'sbg_goal_nnn.dart';

class SbgFlameGameNnn extends FlameGame with PanDetector {
  late final SbgGlovesNnn gloves;
  final Timer spawnTimer = Timer(.8, repeat: true);

  @override
  Color backgroundColor() => const Color.fromRGBO(0, 0, 0, 0);
  @override
  Future<void> onLoad() async {
    addAll([
      SbgGoalNnn(),
      gloves = SbgGlovesNnn(),
    ]);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    spawnTimer.update(dt);
    spawnTimer.onTick = () {
      add(SbgBallNnn());
    };
    super.update(dt);
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    final x = info.eventPosition.global.x;
    gloves.position.x = x;
    super.onPanUpdate(info);
  }
}
