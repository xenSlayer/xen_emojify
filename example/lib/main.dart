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
    final lottie = [
      const XenEmoji(
        'https://fonts.gstatic.com/s/e/notoemoji/latest/1f60d/lottie.json',
        label: 'heart eyes',
        lottieID: '1f60d',
      ),
      const XenEmoji(
        'https://lottie.host/e9e0b847-de55-4537-8406-d1a9a2be02c7/yMBPVCKSru.json',
        label: 'laughing',
        lottieID: '1f606',
      ),
      const XenEmoji(
        'https://lottie.host/f7d6b7cf-58f5-4e5e-8a17-8b6087f2e442/A3QjXpmhk9.json',
        label: 'sunglasses',
        lottieID: '1f60e',
      ),
      const XenEmoji(
        'https://lottie.host/f47215b5-db87-4c46-82f7-874cb904d7a1/UCA1WVixmM.json',
        label: 'indian smirk',
        lottieID: '1f60f',
      ),
      const XenEmoji(
        'https://lottie.host/34bf46c9-be14-4e81-a1ba-49e7e64a0d47/g7iC1sdHC2.json',
        label: 'joy',
        lottieID: '1f602',
      ),
      const XenEmoji(
        'https://fonts.gstatic.com/s/e/notoemoji/latest/1f603/lottie.json',
        label: 'smile',
        lottieID: '1f603',
      ),
    ];

    final dockController = OverlayPortalController();

    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            for (int i = 0; i < 5; i++)
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
                            // dockController: dockController,
                            displayLabel: false,
                            xenEmojifyDock: XenEmojifyDock(
                              dockColor: Colors.red.withOpacity(0.7),
                              onEmojiSelect: (emoji) {
                                setState(() => initialEmoji = emoji);
                              },
                              xenEmojis: lottie,
                            ),
                            initialEmoji: i == 0 ? null : lottie[i],
                          ),
                        ),
                        InkWell(
                          onTap: () => dockController.show(),
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
          ],
        ),
      ),
    );
  }
}
