import 'package:a45/screens/sbg_menu_nnn.dart';
import 'package:a45/screens/sbg_splash_nnn.dart';
import 'package:flutter/material.dart';

import 'sbg_name_nnn.dart';

final sbgOnboardingNotifierNnn = ValueNotifier<bool>(sbgSharedPrefsNnn.getBool('sbgOnboardingNotifierNnn') ?? false);
void sbgOnboardingSetNnn() {
  sbgOnboardingNotifierNnn.value = true;
  sbgSharedPrefsNnn.setBool('sbgOnboardingNotifierNnn', true);
}

class SbgOnboardingNnn extends StatelessWidget {
  const SbgOnboardingNnn({super.key});

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
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text(
                'Protect the goal\n& Collect coins',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Swipe to move the goalkeeper\n& Collect coins to unlock new characters',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
              Expanded(
                child: Image.asset('assets/images/sbg_o1_nnn.png'),
              ),
              SbgButtonNnn(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const SbgOnboarding2Nnn(),
                    ),
                  );
                },
                text: 'CONTINUE',
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.all(5),
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    width: 10,
                    height: 30,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SbgOnboarding2Nnn extends StatelessWidget {
  const SbgOnboarding2Nnn({super.key});

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
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text(
                'Rotate your phone\nin game',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Rotate your phone to play the game\n& Collect coins to unlock new characters',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
              Expanded(
                child: Image.asset('assets/images/sbg_o2_nnn.png'),
              ),
              SbgButtonNnn(
                onPressed: () {
                  sbgOnboardingSetNnn();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const SbgMenuNnn(),
                    ),
                  );
                },
                text: 'CONTINUE',
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.all(5),
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    width: 10,
                    height: 30,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
