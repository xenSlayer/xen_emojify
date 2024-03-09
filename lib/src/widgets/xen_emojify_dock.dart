// BSD License. Copyright © Kiran Paudel. All rights reserved

import 'package:flutter/material.dart';
import 'package:xen_emojify/src/animations/_selected_emoji_animation_mixin.dart';
import 'package:xen_emojify/src/provider/xen_emojify_provider.dart';
import 'package:xen_emojify/xen_emojify.dart';

/// The dock that displays list of [XenEmoji].
/// This widget pops up when the user taps on the [XenEmojify] widget.
/// The user can select an [XenEmoji] from the dock.
class XenEmojifyDock extends StatefulWidget {
  ///
  const XenEmojifyDock({
    required this.xenEmojis,
    this.dockColor = const Color.fromARGB(200, 37, 17, 17),
    this.dockSize = const Size(500, 80),
    this.offSet,
    this.onEmojiSelect,
  }) : assert(xenEmojis.length > 0, 'xenEmojis cannot be empty');

  /// The list of [XenEmoji] to display in the dock.
  final List<XenEmoji> xenEmojis;

  /// The background color of the dock.
  ///
  /// default: [Colors.grey]
  final Color dockColor;

  /// The size of the dock
  ///
  /// default: [Size(500, 80)]
  final Size dockSize;

  /// The offset of the dock.
  ///
  final Offset? offSet;

  /// The callback function that is called when an emoji is selected.
  ///
  /// The selected [XenEmoji] is received as a parameter.
  final void Function(XenEmoji emoji)? onEmojiSelect;

  @override
  State<XenEmojifyDock> createState() => _XenEmojifyDockState();
}

class _XenEmojifyDockState extends State<XenEmojifyDock>
    with SelectedEmojiAnimationMixin {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    final xenEmojify = XenEmojifyProvider.of(context);

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
        itemBuilder: (context, index) => Tooltip(
          message: widget.xenEmojis[index].lottieName,
          child: InkWell(
            onTap: () {
              xenEmojify.setCurrentEmoji(widget.xenEmojis[index]);
              widget.onEmojiSelect?.call(widget.xenEmojis[index]);
              xenEmojify.hideDock();
            },
            child: LottieSource.build(
              src: LottieSource.network,
              url: widget.xenEmojis[index].lottie,
              height: 30,
              width: 30,
            ),
          ),
        ),
      ),
    );
  }
}
