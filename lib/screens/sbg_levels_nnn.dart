// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:a45/game/sbg_game_nnn.dart';
import 'package:a45/screens/sbg_menu_nnn.dart';
import 'package:a45/screens/sbg_name_nnn.dart';
import 'package:a45/screens/sbg_splash_nnn.dart';
import 'package:flame/flame.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final sbgLevelsNotifierNnn = ValueNotifier<int>(sbgSharedPrefsNnn.getInt('sbgLevelsNotifierNnn') ?? 1);
void sbgLevelsSetNnn(int value) {
  if (value < sbgLevelsNotifierNnn.value) {
    return;
  }
  sbgLevelsNotifierNnn.value = value;
  sbgSharedPrefsNnn.setInt('sbgLevelsNotifierNnn', value);
}

class SbgLevelsNnn extends StatelessWidget {
  const SbgLevelsNnn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/sbg_splash_nnn.png',
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SbgAppBarNnn(
                  title: 'Select lvl',
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    itemCount: 40,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          if (index == sbgLevelsNotifierNnn.value - 1) {
                            await Flame.device.setLandscape();
                            await Future.delayed(const Duration(milliseconds: 300));
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SbgGameNnn(
                                  level: index + 1,
                                ),
                              ),
                            );
                          } else if (index < sbgLevelsNotifierNnn.value - 1) {
                            showDialog(
                              context: context,
                              barrierColor: const Color.fromRGBO(13, 89, 132, .9),
                              builder: (_) => const SbgDialogNnn(
                                  title: 'You have already completed this level', buttonText: 'BACK'),
                            );
                          } else if (index > 4) {
                            showDialog(
                              context: context,
                              barrierColor: const Color.fromRGBO(13, 89, 132, .9),
                              builder: (_) => SbgDialogNnn(
                                title: 'Not enough money to buy this level for ${(index * e * 33).toInt()} coins',
                                buttonText: 'BACK',
                              ),
                            );
                          } else if (index > sbgLevelsNotifierNnn.value - 1) {
                            showDialog(
                              context: context,
                              barrierColor: const Color.fromRGBO(13, 89, 132, .9),
                              builder: (_) => const SbgDialogNnn(
                                  title: 'Complete previous levels to unlock this level', buttonText: 'BACK'),
                            );
                          }
                        },
                        child: ValueListenableBuilder(
                          valueListenable: sbgLevelsNotifierNnn,
                          builder: (context, level, child) {
                            return Container(
                              margin: const EdgeInsets.all(5),
                              padding: const EdgeInsets.symmetric(horizontal: 24),
                              height: 90,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(.3),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      color: const Color.fromRGBO(6, 109, 167, 1),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Icon(
                                      index <= level - 1 ? Icons.check : CupertinoIcons.lock_fill,
                                      size: 20,
                                      color:
                                          index != level - 1 ? Colors.white : const Color.fromRGBO(255, 255, 255, 0.3),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Text(
                                    '${index + 1} level',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic),
                                  ),
                                  const Spacer(),
                                  if (index < level - 1) ...[
                                    for (int i = 0; i < 3; i++)
                                      Padding(
                                        padding: const EdgeInsets.all(2),
                                        child: Image.asset(
                                          'assets/images/sbg_ball_icon_nnn.png',
                                          height: 35,
                                        ),
                                      )
                                  ],
                                  if (index == level - 1) ...[
                                    const StrokeText(
                                      text: 'Active',
                                      strokeColor: Colors.white,
                                      strokeWidth: 4,
                                      textStyle: TextStyle(
                                        color: Colors.red,
                                        fontSize: 26,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ],
                                  if (index > level - 1) ...[
                                    Text(
                                      'Closed',
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(.6),
                                        fontSize: 20,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SbgAppBarNnn extends StatelessWidget {
  const SbgAppBarNnn({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset('assets/images/sbg_back_nnn.png'),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  height: 0,
                  fontSize: 33,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 45,
                    child: ValueListenableBuilder(
                      valueListenable: sbgMoneyNotifierNnn,
                      builder: (context, coins, child) {
                        return FittedBox(
                          child: Text(
                            coins.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              height: 0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 5),
                  Image.asset(
                    'assets/images/sbg_coin_nnn.png',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SbgDialogNnn extends StatelessWidget {
  const SbgDialogNnn({super.key, required this.title, required this.buttonText});
  final String title;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StrokeText(
            text: title,
            strokeColor: Colors.white,
            strokeWidth: 5,
            textStyle: const TextStyle(
              fontFamily: 'Barlow',
              fontSize: 33,
              color: Color.fromRGBO(37, 47, 108, 1),
            ),
          ),
          const SizedBox(height: 20),
          SbgButtonNnn(
            onPressed: () {
              Navigator.pop(context);
            },
            text: buttonText,
          ),
        ],
      ),
    );
  }
}

class StrokeText extends StatelessWidget {
  final String text;
  final double strokeWidth;
  final Color textColor;
  final Color strokeColor;
  final TextStyle? textStyle;

  const StrokeText({
    super.key,
    required this.text,
    this.strokeWidth = 1,
    this.strokeColor = Colors.black,
    this.textColor = Colors.white,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = strokeWidth
              ..color = strokeColor,
          ).merge(textStyle),
        ),
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(color: textColor).merge(textStyle),
        ),
      ],
    );
  }
}
