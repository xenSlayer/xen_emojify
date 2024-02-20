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
        emojiName: 'heart_eyes',
        emojiID: '1f60d',
      ),
      const XenEmoji(
        'https://fonts.gstatic.com/s/e/notoemoji/latest/1f606/lottie.json',
        emojiName: 'laughing',
        emojiID: '1f606',
      ),
      const XenEmoji(
        'https://fonts.gstatic.com/s/e/notoemoji/latest/1f60e/lottie.json',
        emojiName: 'sunglasses',
        emojiID: '1f60e',
      ),
    ];

    return Scaffold(
      body: ListView(
        children: [
          const Text('abc'),
          const Text('abc'),
          const Text('abc'),
          Center(
            child: XenEmojify(
              lottieSource: LottieSource.network,
              selectedEmojiSize: 10,
              xenEmojifyDock: XenEmojifyDock(
                xenEmojis: lottie,
                onEmojiSelect: print,
              ),
              initialEmoji: lottie[1],
            ),
          ),
        ],
      ),
    );
  }
}
