import 'package:a45/game/flame/sbg_flame_game_nnn.dart';
import 'package:a45/screens/sbg_name_nnn.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:stroke_text/stroke_text.dart';

class SbgGameNnn extends StatefulWidget {
  const SbgGameNnn({super.key, required this.level});
  final int level;

  @override
  State<SbgGameNnn> createState() => _SbgGameNnnState();
}

class _SbgGameNnnState extends State<SbgGameNnn> {
  final livesNotifier = ValueNotifier(3);
  late final game = SbgFlameGameNnn(lives: livesNotifier);
  @override
  void initState() {
    livesNotifier.addListener(() async {
      if (livesNotifier.value == 0) {
        game.pauseEngine();
       final isRestart= await showDialog(
          context: context,
          barrierColor: const Color.fromRGBO(13, 89, 132, .9),
          builder: (_) => _SbgLoseDialog(
            level: widget.level,
          ),
        );
        if (isRestart == true) {
          game.reset();
          livesNotifier.value = 3;
        }
      }
    });
    super.initState();
  }

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
            Positioned(
              bottom: 10,
              left: 10,
              child: ValueListenableBuilder(
                  valueListenable: livesNotifier,
                  builder: (context, lives, _) {
                    return Row(
                      children: [
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 300),
                          opacity: lives >= 1 ? 1 : 0.5,
                          child: Image.asset(
                            'assets/images/sbg_ball_icon_nnn.png',
                            height: 35,
                          ),
                        ),
                        const SizedBox(width: 10),
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 300),
                          opacity: lives >= 2 ? 1 : 0.5,
                          child: Image.asset(
                            'assets/images/sbg_ball_icon_nnn.png',
                            height: 35,
                          ),
                        ),
                        const SizedBox(width: 10),
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 300),
                          opacity: lives >= 3 ? 1 : 0.5,
                          child: Image.asset(
                            'assets/images/sbg_ball_icon_nnn.png',
                            height: 35,
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class _SbgLoseDialog extends StatelessWidget {
  const _SbgLoseDialog({
    super.key,
    required this.level,
  });

  final int level;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const StrokeText(
              text: 'You Lose',
              strokeColor: Colors.white,
              strokeWidth: 6,
              textStyle: TextStyle(
                fontFamily: 'Barlow',
                fontSize: 40,
                color: Color.fromRGBO(37, 47, 108, 1),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: SbgButtonNnn(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    text: 'MENU',
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: SbgButtonNnn(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    text: 'PLAY AGAIN',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
