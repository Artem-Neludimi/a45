import 'package:flutter/material.dart';
import 'package:flame/flame.dart';
import 'package:flutter/widgets.dart';
import 'package:stroke_text/stroke_text.dart';

class SbgSplashNnn extends StatefulWidget {
  const SbgSplashNnn({super.key});

  @override
  State<SbgSplashNnn> createState() => _SbgSplashNnnState();
}

class _SbgSplashNnnState extends State<SbgSplashNnn> {
  double _progress = 0;
  @override
  void initState() {
    Flame.device.fullScreen();
    Flame.device.setPortrait();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      do {
        setState(() => _progress += .01);
        await Future.delayed(const Duration(milliseconds: 30));
      } while (_progress < 1);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/sbg_splash_nnn.png',
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            Image.asset('assets/images/sbg_splash_footballer_nnn.png'),
            const SizedBox(height: 20),
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
            const SizedBox(height: 60),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 80,
                  height: 80,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white.withOpacity(.2),
                    value: _progress,
                    color: Colors.white,
                    strokeWidth: 9,
                  ),
                ),
                Text(
                  '${(_progress * 100).toInt()}%',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
