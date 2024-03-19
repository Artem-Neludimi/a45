import 'package:a45/screens/sbg_levels_nnn.dart';
import 'package:a45/screens/sbg_menu_nnn.dart';
import 'package:a45/screens/sbg_name_nnn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'sbg_splash_nnn.dart';

final sbgMinusTenNotifierNnn = ValueNotifier(sbgSharedPrefsNnn.getInt('sbgMinusTenNotifierNnn') ?? 1);
void sbgMinusTenIncrementNnn() {
  sbgMinusTenNotifierNnn.value++;
  sbgSharedPrefsNnn.setInt('sbgMinusTenNotifierNnn', sbgMinusTenNotifierNnn.value);
}

void sbgMinusTenDecrementNnn() {
  sbgMinusTenNotifierNnn.value--;
  sbgSharedPrefsNnn.setInt('sbgMinusTenNotifierNnn', sbgMinusTenNotifierNnn.value);
}

final sbgMinusGoalNotifierNnn = ValueNotifier(sbgSharedPrefsNnn.getInt('sbgMinusGoalNotifierNnn') ?? 1);
void sbgMinusGoalIncrementNnn() {
  sbgMinusGoalNotifierNnn.value++;
  sbgSharedPrefsNnn.setInt('sbgMinusGoalNotifierNnn', sbgMinusGoalNotifierNnn.value);
}

void sbgMinusGoalDecrementNnn() {
  sbgMinusGoalNotifierNnn.value--;
  sbgSharedPrefsNnn.setInt('sbgMinusGoalNotifierNnn', sbgMinusGoalNotifierNnn.value);
}

class SbgShopNnn extends StatelessWidget {
  const SbgShopNnn({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: sbgMoneyNotifierNnn,
        builder: (context, money, _) {
          return Scaffold(
            body: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/sbg_splash_nnn.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const SbgAppBarNnn(title: 'Shop'),
                    const SizedBox(height: 20),
                    Expanded(
                      child: ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Text(
                              'BOOSTS',
                              style: TextStyle(
                                color: Colors.white.withOpacity(.5),
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          ValueListenableBuilder(
                            valueListenable: sbgMinusTenNotifierNnn,
                            builder: (context, minusTen, _) {
                              return Stack(
                                children: [
                                  _SbgItemNnn(
                                    leading: const Text(
                                      '- 10 sec',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 26,
                                      ),
                                    ),
                                    price: 100,
                                    isActive: false,
                                    onPressed: money < 100
                                        ? null
                                        : () {
                                            sbgMinusTenIncrementNnn();
                                            sbgMoneyAddNnn(-100);
                                          },
                                  ),
                                  Positioned(
                                    left: 0,
                                    top: 0,
                                    height: 35,
                                    width: 35,
                                    child: DecoratedBox(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color.fromRGBO(235, 22, 40, 1),
                                      ),
                                      child: Center(
                                        child: Text(
                                          minusTen.toString(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          ValueListenableBuilder(
                            valueListenable: sbgMinusGoalNotifierNnn,
                            builder: (context, minusGoal, _) {
                              return Stack(
                                children: [
                                  _SbgItemNnn(
                                    leading: const Text(
                                      '- Goal',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 26,
                                      ),
                                    ),
                                    price: 200,
                                    isActive: false,
                                    onPressed: money < 200
                                        ? null
                                        : () {
                                            sbgMinusGoalIncrementNnn();
                                            sbgMoneyAddNnn(-200);
                                          },
                                  ),
                                  Positioned(
                                    left: 0,
                                    top: 0,
                                    height: 35,
                                    width: 35,
                                    child: DecoratedBox(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color.fromRGBO(235, 22, 40, 1),
                                      ),
                                      child: Center(
                                        child: Text(
                                          minusGoal.toString(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Text(
                              'BALLS',
                              style: TextStyle(
                                color: Colors.white.withOpacity(.5),
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          _SbgItemNnn(
                            leading: Image.asset(
                              'assets/images/sbg_ball_nnn.png',
                            ),
                            price: 0,
                            isActive: true,
                          ),
                          _SbgItemNnn(
                            leading: Image.asset(
                              'assets/images/sbg_shop_b2_nnn.png',
                            ),
                            price: 500,
                            isActive: false,
                          ),
                          _SbgItemNnn(
                            leading: Image.asset(
                              'assets/images/sbg_shop_b3_nnn.png',
                            ),
                            price: 750,
                            isActive: false,
                          ),
                          _SbgItemNnn(
                            leading: Image.asset(
                              'assets/images/sbg_shop_b4_nnn.png',
                            ),
                            price: 1000,
                            isActive: false,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Text(
                              'GLOVES',
                              style: TextStyle(
                                color: Colors.white.withOpacity(.5),
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          _SbgItemNnn(
                            leading: Image.asset(
                              'assets/images/sbg_gloves_nnn.png',
                            ),
                            price: 0,
                            isActive: true,
                          ),
                          _SbgItemNnn(
                            leading: Image.asset(
                              'assets/images/sbg_shop_g2_nnn.png',
                            ),
                            price: 500,
                            isActive: false,
                          ),
                          _SbgItemNnn(
                            leading: Image.asset(
                              'assets/images/sbg_shop_g3_nnn.png',
                            ),
                            price: 750,
                            isActive: false,
                          ),
                          _SbgItemNnn(
                            leading: Image.asset(
                              'assets/images/sbg_shop_g4_nnn.png',
                            ),
                            price: 1000,
                            isActive: false,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class _SbgItemNnn extends StatelessWidget {
  const _SbgItemNnn({
    required this.leading,
    required this.price,
    required this.isActive,
    this.onPressed,
  });
  final Widget leading;
  final int price;
  final bool isActive;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      height: 90,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          leading,
          const Spacer(),
          Image.asset(
            'assets/images/sbg_coin_nnn.png',
            width: 30,
          ),
          const SizedBox(width: 6),
          SizedBox(
            width: 60,
            child: Text(
              price.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(width: 16),
          if (isActive)
            Text(
              'ACTIVE',
              style: TextStyle(
                color: Colors.white.withOpacity(.3),
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontSize: 21.5,
              ),
            )
          else
            SbgButtonNnn(
              isSmall: true,
              onPressed: onPressed ??
                  () {
                    showDialog(
                      context: context,
                      barrierColor: const Color.fromRGBO(13, 89, 132, .9),
                      builder: (_) => const SbgDialogNnn(
                        title: 'Not enough coins to buy',
                        buttonText: 'BACK',
                      ),
                    );
                  },
              text: 'BUY',
            )
        ],
      ),
    );
  }
}
