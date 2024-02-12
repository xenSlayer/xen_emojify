// BSD License. Copyright © Kiran Paudel. All rights reserved

import 'package:flutter/material.dart';
import 'package:xen_emojify/xen_emojify.dart';

void main() {
  runApp(const MyApp());
}

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
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 300),
          Center(
            child: ReactionButton(
              reactions: AnimatedEmojis.values.sublist(0, 10).toList(),
            ),
          ),
          const SizedBox(height: 100),
          const XenEmojify(
            xenEmojifyDock: XenEmojifyDock(
              onTap: print,
              xenEmojis: [
                AnimatedEmojis.airplaneArrival,
                AnimatedEmojis.worried,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
