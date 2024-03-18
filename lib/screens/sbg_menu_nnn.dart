import 'package:a45/screens/sbg_levels_nnn.dart';
import 'package:a45/screens/sbg_name_nnn.dart';
import 'package:flutter/material.dart';
import 'package:stroke_text/stroke_text.dart';

class SbgMenuNnn extends StatelessWidget {
  const SbgMenuNnn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/sbg_menu_bg_nnn.png',
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StrokeText(
                      text: 'Sporting ',
                      strokeColor: Colors.white,
                      strokeWidth: 6,
                      textStyle: TextStyle(
                        fontFamily: 'Barlow',
                        fontSize: 40,
                        color: Color.fromRGBO(37, 47, 108, 1),
                      ),
                    ),
                    StrokeText(
                      text: 'Ball',
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
                const SizedBox(height: 40),
                SbgButtonNnn(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SbgLevelsNnn(),
                      ),
                    );
                  },
                  text: 'START GAME',
                ),
                const SizedBox(height: 20),
                SbgButtonNnn(
                  onPressed: () {},
                  text: 'SHOP',
                ),
                const SizedBox(height: 20),
                SbgButtonNnn(
                  onPressed: () {},
                  text: 'SETTINGS',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
