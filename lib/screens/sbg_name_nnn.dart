import 'dart:convert';
import 'dart:typed_data';

import 'package:a45/screens/sbg_splash_nnn.dart';
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
  const SbgNameNnn({super.key});

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
                TextField(
                  onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
                  onChanged: sbgNameOnChangedNnn,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  cursorColor: Colors.white,
                  decoration: const InputDecoration(
                    hintText: 'your name',
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color.fromRGBO(255, 255, 255, .7)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color.fromRGBO(255, 255, 255, .7)),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color.fromRGBO(255, 255, 255, .7)),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SbgButtonNnn(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const SbgSplashNnn(),
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
  const SbgButtonNnn({super.key, required this.onPressed, required this.text});
  final VoidCallback onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset('assets/images/sbg_button_nnn.png'),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
