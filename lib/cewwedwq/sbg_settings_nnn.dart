import 'package:a45/sbg_constats_nnn.dart';
import 'package:a45/xxllslsaa/sbg_levels_nnn.dart';
import 'package:a45/xxllslsaa/sbg_splash_nnn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:system_settings/system_settings.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import '../xxllslsaa/ewdwew/sbg_name_nnn.dart';

final sbgNotificationNotifierNnn =
    ValueNotifier<bool>(sbgSharedPrefsNnn.getBool('sbgNotificationNotifierNnn') ?? false);
void sbgNotificationToggleNnn() {
  sbgNotificationNotifierNnn.value = !sbgNotificationNotifierNnn.value;
  sbgSharedPrefsNnn.setBool('sbgNotificationNotifierNnn', sbgNotificationNotifierNnn.value);
}

final sbgSoundNotifierNnn = ValueNotifier<bool>(sbgSharedPrefsNnn.getBool('sbgSoundNotifierNnn') ?? false);
void sbgSoundToggleNnn() {
  sbgSoundNotifierNnn.value = !sbgSoundNotifierNnn.value;
  sbgSharedPrefsNnn.setBool('sbgSoundNotifierNnn', sbgSoundNotifierNnn.value);
}

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
                        ValueListenableBuilder(
                            valueListenable: sbgSoundNotifierNnn,
                            builder: (context, sound, _) {
                              return ListTile(
                                onTap: () {
                                  if (sound) {
                                    FlameAudio.bgm.stop();
                                  } else {
                                    FlameAudio.bgm.play('sbg_bgm_nnn.mp3');
                                  }
                                  sbgSoundToggleNnn();
                                },
                                contentPadding: EdgeInsets.zero,
                                title: const Text(
                                  'Game Sounds',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                trailing: IgnorePointer(
                                  child: CupertinoSwitch(
                                    activeColor: Colors.red,
                                    trackColor: Colors.black.withOpacity(.5),
                                    value: sound,
                                    onChanged: (value) {},
                                  ),
                                ),
                              );
                            }),
                        Divider(
                          height: 2,
                          color: Colors.white.withOpacity(.3),
                          thickness: 2,
                        ),
                        ListTile(
                          onTap: () async {
                            final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
                            await flutterLocalNotificationsPlugin
                                .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
                                ?.requestPermissions(
                                  alert: true,
                                  badge: true,
                                  sound: true,
                                );

                            final check = await flutterLocalNotificationsPlugin
                                .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()!
                                .checkPermissions();
                            if (check?.isEnabled ?? false) {
                              sbgNotificationToggleNnn();
                            } else {
                              SystemSettings.appNotifications();
                            }
                          },
                          contentPadding: EdgeInsets.zero,
                          title: const Text(
                            'Notifications',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: ValueListenableBuilder(
                              valueListenable: sbgNotificationNotifierNnn,
                              builder: (context, value, _) {
                                return IgnorePointer(
                                  child: CupertinoSwitch(
                                    activeColor: Colors.red,
                                    trackColor: Colors.black.withOpacity(.5),
                                    value: value,
                                    onChanged: (value) {},
                                  ),
                                );
                              }),
                        ),
                        Divider(
                          height: 2,
                          color: Colors.white.withOpacity(.3),
                          thickness: 2,
                        ),
                        ListTile(
                          onTap: () {
                            launchUrl(Uri.parse(sbgPrivacyNnn));
                          },
                          contentPadding: EdgeInsets.zero,
                          title: const Text(
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
                        ListTile(
                          onTap: () {
                            launchUrl(Uri.parse(sbgTermsNnn));
                          },
                          contentPadding: EdgeInsets.zero,
                          title: const Text(
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
                        ListTile(
                          onTap: () {
                            Share.share('Try this app!');
                          },
                          contentPadding: EdgeInsets.zero,
                          title: const Text(
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
