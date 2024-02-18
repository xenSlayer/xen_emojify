// BSD License. Copyright © Kiran Paudel. All rights reserved

import 'package:flutter/material.dart';
import 'package:xen_emojify/src/enums.dart';
import 'package:xen_emojify/xen_emojify.dart';

///
class XenEmojifyDock extends StatelessWidget {
  /// [XenEmojifyDock] is a widget that allows you to display emojis
  const XenEmojifyDock({
    required this.xenEmojis,
    this.dockColor = const Color.fromARGB(200, 37, 17, 17),
    this.dockSize = const Size(500, 80),
  });

  ///
  final List<XenEmoji> xenEmojis;

  /// The color of the dock
  /// default: [Colors.grey]
  final Color dockColor;

  /// The size of the dock
  ///
  /// default: [Size(300, 200)]
  final Size dockSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: dockSize,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: dockColor,
          borderRadius: const BorderRadius.all(Radius.circular(32)),
        ),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: xenEmojis.length,
          itemBuilder: (context, index) => LottieSource.build(
            src: LottieSource.network,
            url: xenEmojis[index].lottie,
            height: 30,
            width: 30,
          ),
        ),
      ),
    );
  }
}
