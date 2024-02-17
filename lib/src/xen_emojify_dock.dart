// BSD License. Copyright © Kiran Paudel. All rights reserved

import 'package:flutter/material.dart';

///
class XenEmojifyDock extends StatelessWidget {
  /// [XenEmojifyDock] is a widget that allows you to display emojis
  const XenEmojifyDock({
    this.dockColor = const Color.fromARGB(200, 37, 17, 17),
    this.dockSize = const Size(500, 80),
  });

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
      ),
    );
  }
}
