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

class MyEmojifyWidget extends StatelessWidget {
  const MyEmojifyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('react', style: TextStyle(fontWeight: FontWeight.bold));
  }
}

class XenEmojifyExample extends StatefulWidget {
  const XenEmojifyExample({super.key});

  @override
  State<XenEmojifyExample> createState() => _XenEmojifyExampleState();
}

class _XenEmojifyExampleState extends State<XenEmojifyExample> {
  XenEmoji initialEmoji = const XenEmoji(
    'https://fonts.gstatic.com/s/e/notoemoji/latest/1f60d/lottie.json',
    label: 'heart eyes',
    lottieID: '1f60d',
  );

  @override
  Widget build(BuildContext context) {
    final lotties = [
      const XenEmoji(
        'https://fonts.gstatic.com/s/e/notoemoji/latest/1f60d/lottie.json',
        label: 'Heart Eyes',
        lottieID: '1f60d',
      ),
      const XenEmoji(
        'https://fonts.gstatic.com/s/e/notoemoji/latest/1f525/lottie.json',
        label: 'Fire',
        lottieID: '1f525',
      ),
      const XenEmoji(
        'https://fonts.gstatic.com/s/e/notoemoji/latest/1f4a9/lottie.json',
        label: 'Poop',
        lottieID: '1f4a9',
      ),
      const XenEmoji(
        'https://fonts.gstatic.com/s/e/notoemoji/latest/1f984/lottie.json',
        label: 'Unicorn',
        lottieID: '1f984',
      ),
      const XenEmoji(
        'https://fonts.gstatic.com/s/e/notoemoji/latest/1faa9/lottie.json',
        label: 'Mirror Ball',
        lottieID: '1faa9',
      ),
      const XenEmoji(
        'https://fonts.gstatic.com/s/e/notoemoji/latest/1f603/lottie.json',
        label: 'Smile',
        lottieID: '1f603',
      ),
      const XenEmoji(
        'https://fonts.gstatic.com/s/e/notoemoji/latest/26a1/lottie.json',
        label: 'Zap',
        lottieID: '26a1',
      ),
      const XenEmoji(
        'https://fonts.gstatic.com/s/e/notoemoji/latest/1f47d/lottie.json',
        label: 'Alien',
        lottieID: '1f47d',
      ),
      const XenEmoji(
        'https://fonts.gstatic.com/s/e/notoemoji/latest/1f92e/lottie.json',
        label: 'Vomit',
        lottieID: '1f92e',
      ),
    ];

    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            for (final (i, lottie) in lotties.indexed)
              Align(
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
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: XenEmojify(
                            lottieSource: LottieSources.network,
                            showLabel: false,
                            xenEmojifyDock: XenEmojifyDock(
                              dockColor: Colors.cyan.withOpacity(0.7),
                              onEmojiSelect: (emoji) {
                                setState(() => initialEmoji = emoji);
                              },
                              xenEmojis: lotties,
                            ),
                            initialEmoji: i == 0 ? null : lottie,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Wrap(
                            children: [
                              Icon(Icons.comment),
                              SizedBox(width: 5),
                              Text('Comment'),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Wrap(
                            children: [
                              Icon(Icons.share_rounded),
                              SizedBox(width: 5),
                              Text('Share'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
