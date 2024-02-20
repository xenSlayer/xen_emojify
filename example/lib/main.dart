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
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 300,
                height: 300,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcSc4bnfG3zNmNB6Dk4C3vge8FxKkdFH64E96jiW8FKdS_04gDdF',
                    ),
                  ),
                ),
              ),
            ),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 5,
              children: [
                XenEmojify(
                  lottieSource: LottieSource.network,
                  selectedEmojiSize: 10,
                  xenEmojifyDock: XenEmojifyDock(xenEmojis: lottie),
                  // initialEmoji: lottie[2],
                ),
                InkWell(
                  onTap: () {},
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Wrap(
                      children: [
                        Icon(Icons.comment),
                        SizedBox(width: 5),
                        Text('Comment'),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Wrap(
                      children: [
                        Icon(Icons.share_rounded),
                        SizedBox(width: 5),
                        Text('Share'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
