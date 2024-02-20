// BSD License. Copyright © Kiran Paudel. All rights reserved

import 'package:flutter/material.dart';
import 'package:xen_emojify/xen_emojify.dart';

///
class XenEmojifyDock extends StatefulWidget {
  /// [XenEmojifyDock] is a widget that allows you to display emojis
  const XenEmojifyDock({
    required this.xenEmojis,
    this.dockColor = const Color.fromARGB(200, 37, 17, 17),
    this.dockSize = const Size(500, 80),
    this.onEmojiSelect,
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

  ///
  final void Function(XenEmoji emoji)? onEmojiSelect;

  @override
  State<XenEmojifyDock> createState() => _XenEmojifyDockState();
}

class _XenEmojifyDockState extends State<XenEmojifyDock> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.dockSize.height,
      width: widget.dockSize.width,
      decoration: BoxDecoration(
        color: widget.dockColor,
        borderRadius: const BorderRadius.all(Radius.circular(32)),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.xenEmojis.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () => widget.onEmojiSelect?.call(widget.xenEmojis[index]),
          child: LottieSource.build(
            src: LottieSource.network,
            url: widget.xenEmojis[index].lottie,
            height: 30,
            width: 30,
          ),
        ),
      ),
    );
  }
}
