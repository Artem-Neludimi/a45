import 'dart:async';

import 'package:a45/cewwedwq/wqdeqwxx/sbg_flame_game_nnn.dart';
import 'package:a45/xxllslsaa/sbg_levels_nnn.dart';
import 'package:a45/xxllslsaa/sbg_menu_nnn.dart';
import 'package:a45/xxllslsaa/ewdwew/sbg_name_nnn.dart';
import 'package:a45/xxllslsaa/sbg_shop_nnn.dart';
import 'package:a45/xxllslsaa/sbg_splash_nnn.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

final sbgBonusNotifierNnn = ValueNotifier(sbgSharedPrefsNnn.getBool('sbgBonusNotifierNnn') ?? false);
void sbgBonusSetNnn() {
  sbgBonusNotifierNnn.value = true;
  sbgSharedPrefsNnn.setBool('sbgBonusNotifierNnn', true);
}

class SbgGameNnn extends StatefulWidget {
  const SbgGameNnn({super.key, required this.level});
  final int level;

  @override
  State<SbgGameNnn> createState() => _SbgGameNnnState();
}

class _SbgGameNnnState extends State<SbgGameNnn> {
  Timer? _timer;
  bool isTimerPaused = false;
  late final ValueNotifier<int> _timerTick = ValueNotifier(50 + widget.level * 10);

  final livesNotifier = ValueNotifier(3);
  late final game = SbgFlameGameNnn(lives: livesNotifier);
  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!isTimerPaused) _timerTick.value--;
    });
    _timerTick.addListener(() {
      if (_timerTick.value <= 0) {
        game.pauseEngine();
        _timer?.cancel();
        sbgLevelsSetNnn(widget.level + 1);
        showDialog(
          context: context,
          barrierColor: const Color.fromRGBO(13, 89, 132, .9),
          builder: (_) => _SbgWinDialog(
            level: widget.level,
            lives: livesNotifier.value,
          ),
        );
      }
    });
    livesNotifier.addListener(() async {
      if (livesNotifier.value == 0) {
        game.pauseEngine();
        _timer?.cancel();
        final isRestart = await showDialog(
          context: context,
          barrierColor: const Color.fromRGBO(13, 89, 132, .9),
          builder: (_) => _SbgLoseDialog(
            level: widget.level,
          ),
        );
        if (isRestart == true) {
          game.reset();
          _timerTick.value = 50 + widget.level * 10;
          _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
            if (!isTimerPaused) _timerTick.value--;
          });
          livesNotifier.value = 3;
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    Flame.device.setPortrait();
    _timer?.cancel();
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
              bottom: 8,
              right: 8,
              height: 30,
              child: Row(
                children: [
                  ValueListenableBuilder(
                      valueListenable: sbgMinusTenNotifierNnn,
                      builder: (context, value, _) {
                        return GestureDetector(
                          onTap: () {
                            if (value > 0) {
                              sbgMinusTenDecrementNnn();
                              _timerTick.value -= 10;
                            }
                          },
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 300),
                            opacity: value > 0 ? 1 : 0.5,
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Image.asset('assets/images/sbg_10_sec_nnn.png'),
                                Positioned(
                                  top: -5,
                                  left: -5,
                                  height: 20,
                                  width: 20,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      ),
                                      color: Colors.white.withOpacity(.4),
                                    ),
                                    child: Center(
                                      child: Text(
                                        value.toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                  const SizedBox(width: 5),
                  ValueListenableBuilder(
                      valueListenable: livesNotifier,
                      builder: (context, lives, _) {
                        return ValueListenableBuilder(
                            valueListenable: sbgMinusGoalNotifierNnn,
                            builder: (context, minusGoal, _) {
                              return GestureDetector(
                                onTap: () {
                                  if (minusGoal > 0 && lives < 3) {
                                    sbgMinusGoalDecrementNnn();
                                    livesNotifier.value++;
                                  }
                                },
                                child: AnimatedOpacity(
                                  duration: const Duration(milliseconds: 300),
                                  opacity: minusGoal > 0 && lives < 3 ? 1 : 0.5,
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Image.asset('assets/images/sbg_minus_goal_nnn.png'),
                                      Positioned(
                                        top: -5,
                                        left: -5,
                                        height: 20,
                                        width: 20,
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Colors.white,
                                              width: 2,
                                            ),
                                            color: Colors.white.withOpacity(.4),
                                          ),
                                          child: Center(
                                            child: Text(
                                              minusGoal.toString(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      }),
                ],
              ),
            ),
            Positioned(
              top: 8,
              left: 0,
              right: 0,
              child: Center(
                child: ValueListenableBuilder(
                  valueListenable: _timerTick,
                  builder: (context, value, _) {
                    return StrokeText(
                      text: _build0000Timer(value),
                      textStyle: const TextStyle(
                        fontFamily: 'Barlow',
                        fontSize: 30,
                        color: Color.fromRGBO(37, 47, 108, 1),
                      ),
                      strokeWidth: 6,
                      strokeColor: Colors.white,
                    );
                  },
                ),
              ),
            ),
            Positioned(
              top: 7,
              left: 7,
              child: GestureDetector(
                onTap: () async {
                  isTimerPaused = true;
                  game.pauseEngine();
                  final isRestart = await showDialog(
                    context: context,
                    barrierColor: const Color.fromRGBO(13, 89, 132, .9),
                    builder: (_) => _SbgPauseDialog(
                      level: widget.level,
                    ),
                  );
                  if (isRestart == true) {
                    game.resumeEngine();
                    isTimerPaused = false;
                  }
                },
                child: Image.asset(
                  'assets/images/sbg_pause_nnn.png',
                  height: 35,
                ),
              ),
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

  String _build0000Timer(int time) {
    if (time < 0) {
      return '00:00';
    }
    final minutes = (time / 60).floor().toString().padLeft(2, '0');
    final seconds = (time % 60).floor().toString().padLeft(2, '0');
    return '$minutes:$seconds';
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

class _SbgWinDialog extends StatelessWidget {
  const _SbgWinDialog({
    super.key,
    required this.level,
    required this.lives,
  });

  final int level;
  final int lives;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ValueListenableBuilder(
          valueListenable: sbgBonusNotifierNnn,
          builder: (context, value, _) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: value
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              StrokeText(
                                text: 'Congratulations!',
                                strokeColor: Colors.white,
                                strokeWidth: 6,
                                textStyle: TextStyle(
                                  fontFamily: 'Barlow',
                                  fontSize: 40,
                                  color: Color.fromRGBO(37, 47, 108, 1),
                                ),
                              ),
                              StrokeText(
                                text: ' Your reward',
                                strokeColor: Colors.white,
                                strokeWidth: 6,
                                textStyle: TextStyle(
                                  fontFamily: 'Barlow',
                                  fontSize: 40,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/sbg_coin_nnn.png',
                                height: 35,
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                '100',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                ),
                              )
                            ],
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
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  },
                                  text: 'NEXT LEVEL',
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  : Stack(
                      children: [
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              sbgBonusSetNnn();
                              sbgMoneyAddNnn(100);
                            },
                            child: Image.asset(
                              'assets/images/sbg_gift_nnn.png',
                              width: MediaQuery.of(context).size.width * 1,
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                StrokeText(
                                  text: 'Congratulations!',
                                  strokeColor: Colors.white,
                                  strokeWidth: 6,
                                  textStyle: TextStyle(
                                    fontFamily: 'Barlow',
                                    fontSize: 40,
                                    color: Color.fromRGBO(37, 47, 108, 1),
                                  ),
                                ),
                                StrokeText(
                                  text: ' You Win!',
                                  strokeColor: Colors.white,
                                  strokeWidth: 6,
                                  textStyle: TextStyle(
                                    fontFamily: 'Barlow',
                                    fontSize: 40,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'YOUR RESULTS',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
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
                            ),
                            const SizedBox(height: 20),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                StrokeText(
                                  text: 'TAP TO OPEN YOUR',
                                  strokeColor: Colors.white,
                                  strokeWidth: 3,
                                  textStyle: TextStyle(
                                    fontFamily: 'Barlow',
                                    fontSize: 20,
                                    color: Color.fromRGBO(37, 47, 108, 1),
                                  ),
                                ),
                                StrokeText(
                                  text: ' GIFT BOX',
                                  strokeColor: Colors.white,
                                  strokeWidth: 3,
                                  textStyle: TextStyle(
                                    fontFamily: 'Barlow',
                                    fontSize: 20,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
            );
          }),
    );
  }
}

class _SbgPauseDialog extends StatelessWidget {
  const _SbgPauseDialog({
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
              text: 'Pause',
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
                    text: 'BACK TO GAME',
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
