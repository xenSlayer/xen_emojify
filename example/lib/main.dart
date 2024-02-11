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
      home: XenEmojifyExample(),
    );
  }
}

class XenEmojifyExample extends StatelessWidget {
  const XenEmojifyExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        XenEmojify(),
      ],
    );
  }
}
