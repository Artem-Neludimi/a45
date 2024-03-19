import 'package:a45/screens/sbg_levels_nnn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'sbg_name_nnn.dart';

class SbgSettingsNnn extends StatelessWidget {
  const SbgSettingsNnn({super.key});

  @override
  Widget build(BuildContext context) {
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
          child: SafeArea(
            child: Column(
              children: [
                const SbgAppBarNnn(title: 'Settings'),
                const SizedBox(height: 16),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => const SbgNameNnn(
                            isFromSettings: true,
                          ),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Expanded(
                          child: ClipOval(
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: ValueListenableBuilder(
                                  valueListenable: sbgImageNotifierNnn,
                                  builder: (context, image, _) {
                                    return image ?? Image.asset('assets/images/sbg_avatar_nnn.png');
                                  }),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ValueListenableBuilder(
                            valueListenable: sbgNameNotifierNnn,
                            builder: (context, name, _) {
                              return Text(
                                name!,
                                style: const TextStyle(
                                  fontFamily: 'Barlow',
                                  fontSize: 24,
                                  color: Colors.white,
                                ),
                              );
                            }),
                        const SizedBox(height: 8),
                        Divider(
                          height: 2,
                          color: Colors.white.withOpacity(.3),
                          thickness: 2,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'GENERAL SETTINGS',
                              style: TextStyle(
                                color: Colors.white.withOpacity(.5),
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text(
                            'Sound',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: CupertinoSwitch(
                            activeColor: Colors.red,
                            trackColor: Colors.black.withOpacity(.5),
                            value: false,
                            onChanged: (value) {},
                          ),
                        ),
                        Divider(
                          height: 2,
                          color: Colors.white.withOpacity(.3),
                          thickness: 2,
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text(
                            'Notifications',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: CupertinoSwitch(
                            activeColor: Colors.red,
                            trackColor: Colors.black.withOpacity(.5),
                            value: false,
                            onChanged: (value) {},
                          ),
                        ),
                        Divider(
                          height: 2,
                          color: Colors.white.withOpacity(.3),
                          thickness: 2,
                        ),
                        const ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            'Privacy Policy',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Divider(
                          height: 2,
                          color: Colors.white.withOpacity(.3),
                          thickness: 2,
                        ),
                        const ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            'Terms of Use',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Divider(
                          height: 2,
                          color: Colors.white.withOpacity(.3),
                          thickness: 2,
                        ),
                        const ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            'Share App',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Divider(
                          height: 2,
                          color: Colors.white.withOpacity(.3),
                          thickness: 2,
                        ),
                      ],
                    ),
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
