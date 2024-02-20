// BSD License. Copyright © Kiran Paudel. All rights reserved

import 'package:flutter/material.dart';
import 'package:xen_emojify/xen_emojify.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'XenEmojify Example',
      home: XenEmojifyExample(),
    );
  }
}

class XenEmojifyExample extends StatelessWidget {
  const XenEmojifyExample({super.key});

  @override
  Widget build(BuildContext context) {
    final lottie = [
      const XenEmoji(
        'https://fonts.gstatic.com/s/e/notoemoji/latest/1f60d/lottie.json',
        lottieName: 'heart eyes',
        lottieID: '1f60d',
      ),
      const XenEmoji(
        'https://fonts.gstatic.com/s/e/notoemoji/latest/1f606/lottie.json',
        lottieName: 'laughing',
        lottieID: '1f606',
      ),
      const XenEmoji(
        'https://fonts.gstatic.com/s/e/notoemoji/latest/1f60e/lottie.json',
        lottieName: 'sunglasses',
        lottieID: '1f60e',
      ),
      const XenEmoji(
        'https://fonts.gstatic.com/s/e/notoemoji/latest/1f60f/lottie.json',
        lottieName: 'smirk',
        lottieID: '1f60f',
      ),
      const XenEmoji(
        'https://fonts.gstatic.com/s/e/notoemoji/latest/1f602/lottie.json',
        lottieName: 'joy',
        lottieID: '1f602',
      ),
      const XenEmoji(
        'https://fonts.gstatic.com/s/e/notoemoji/latest/1f603/lottie.json',
        lottieName: 'smile',
        lottieID: '1f603',
      ),
    ];

    return Scaffold(
      body: ListView(
        children: [
          Center(
            child: XenEmojify(
              lottieSource: LottieSource.network,
              selectedEmojiSize: 10,
              xenEmojifyDock: XenEmojifyDock(xenEmojis: lottie),
              initialEmoji: lottie[2],
            ),
          ),
        ],
      ),
    );
  }
}
