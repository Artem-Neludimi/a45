import 'dart:ui';

import 'package:a45/game/flame/sbg_gloves_nnn.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';

import 'sbg_goal_nnn.dart';

class SbgFlameGameNnn extends FlameGame with PanDetector {
  late final SbgGlovesNnn gloves;

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
  void onPanUpdate(DragUpdateInfo info) {
    final x = info.eventPosition.global.x;
    gloves.position.x = x;
    super.onPanUpdate(info);
  }
}
