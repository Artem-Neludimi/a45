import 'package:a45/game/flame/sbg_flame_game_nnn.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SbgGameNnn extends StatefulWidget {
  const SbgGameNnn({super.key, required this.level});
  final int level;

  @override
  State<SbgGameNnn> createState() => _SbgGameNnnState();
}

class _SbgGameNnnState extends State<SbgGameNnn> {
  late final game = SbgFlameGameNnn();

  @override
  void dispose() {
    Flame.device.setPortrait();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/sbg_game_bg_nnn.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            GameWidget(
              game: game,
            ),
          ],
        ),
      ),
    );
  }
}
