import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:a45/screens/sbg_onboarding_nnn.dart';
import 'package:a45/screens/sbg_splash_nnn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

final sbgNameNotifierNnn = ValueNotifier<String?>(sbgSharedPrefsNnn.getString('sbgNameNotifierNnn') ?? '');

void sbgNameOnChangedNnn(String value) {
  sbgNameNotifierNnn.value = value;
  sbgSharedPrefsNnn.setString('sbgNameNotifierNnn', value);
}

final sbgImageNotifierNnn = ValueNotifier<Image?>(sbgGetImageNnn());
Image? sbgGetImageNnn() {
  final image = sbgSharedPrefsNnn.getString("image");
  if (image == null) return null;
  Uint8List bytes = base64Decode(image);
  return Image.memory(bytes, fit: BoxFit.cover);
}

void sbgSaveImageNnn(Uint8List bytes) {
  sbgSharedPrefsNnn.setString("image", base64Encode(bytes));
  sbgImageNotifierNnn.value = Image.memory(bytes, fit: BoxFit.cover);
}

class SbgNameNnn extends StatelessWidget {
  const SbgNameNnn({super.key, this.isFromSettings = false});
  final bool isFromSettings;

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
                const Text(
                  'Enter your name\n& Avatar',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const Spacer(flex: 1),
                const Text(
                  'Touch to change avatar',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Color.fromRGBO(255, 255, 255, .7),
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  flex: 3,
                  child: GestureDetector(
                    onTap: () async {
                      final ImagePicker picker = ImagePicker();

                      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                      sbgSaveImageNnn(await image!.readAsBytes());
                    },
                    child: ValueListenableBuilder(
                        valueListenable: sbgImageNotifierNnn,
                        builder: (context, image, _) {
                          if (image != null) {
                            return ClipOval(
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: image,
                              ),
                            );
                          }
                          return Image.asset('assets/images/sbg_avatar_nnn.png');
                        }),
                  ),
                ),
                const Spacer(flex: 1),
                const Text(
                  'Enter your name',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Color.fromRGBO(255, 255, 255, .7),
                    fontSize: 15,
                  ),
                ),
                ValueListenableBuilder(
                    valueListenable: sbgNameNotifierNnn,
                    builder: (context, name, _) {
                      return TextField(
                        onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
                        onChanged: sbgNameOnChangedNnn,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          hintText: name ?? 'your name',
                          hintStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          border: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(255, 255, 255, .7)),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(255, 255, 255, .7)),
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(255, 255, 255, .7)),
                          ),
                        ),
                      );
                    }),
                const SizedBox(height: 20),
                SbgButtonNnn(
                  onPressed: () {
                    if (isFromSettings) {
                      Navigator.pop(context);
                      return;
                    }
                    if (sbgNameNotifierNnn.value == null || sbgNameNotifierNnn.value!.isEmpty) {
                      final random = Random().nextInt(9000) + 1000;
                      sbgNameOnChangedNnn('Player $random');
                    }
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const SbgOnboardingNnn(),
                      ),
                    );
                  },
                  text: isFromSettings ? 'BACK' : 'CONTINUE',
                ),
                const SizedBox(height: 15),
                if (!isFromSettings)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(5),
                        width: 10,
                        height: 30,
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
      ),
    );
  }
}

class SbgButtonNnn extends StatelessWidget {
  const SbgButtonNnn({
    super.key,
    required this.onPressed,
    required this.text,
    this.isSmall = false,
  });
  final VoidCallback? onPressed;
  final String text;
  final bool isSmall;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            isSmall ? 'assets/images/sbg_small_button_nnn.png' : 'assets/images/sbg_button_nnn.png',
            height: isSmall ? 40 : 70,
          ),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
