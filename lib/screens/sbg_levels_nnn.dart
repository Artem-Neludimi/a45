// ignore_for_file: use_build_context_synchronously

import 'package:a45/game/sbg_game_nnn.dart';
import 'package:a45/screens/sbg_splash_nnn.dart';
import 'package:flame/flame.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stroke_text/stroke_text.dart';

final sbgLevelsNotifierNnn = ValueNotifier<int>(sbgSharedPrefsNnn.getInt('sbgLevelsNotifierNnn') ?? 1);
void sbgLevelsSetNnn(int value) {
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
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset('assets/images/sbg_back_nnn.png'),
            ),
          ),
          Expanded(
            flex: 4,
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
          const Spacer(flex: 1),
        ],
      ),
    );
  }
}
