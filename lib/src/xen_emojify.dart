// BSD License. Copyright © Kiran Paudel. All rights reserved

import 'package:animated_emoji/animated_emoji.dart';
import 'package:flutter/material.dart';
import 'package:xen_emojify/src/xen_emoji.dart';
import 'package:xen_emojify/src/xen_emojify_animation_mixin.dart';
import 'package:xen_emojify/src/xen_emojify_controller_mixin.dart';
import 'package:xen_emojify/src/xen_emojify_widget.dart';

///
class XenEmojify extends StatefulWidget {
  /// [XenEmojify] is a widget that allows you to display emojis.
  const XenEmojify({
    required this.animatedEmojis,
    this.emojifyWidget,
    this.onEmojiSelect,
  });

  /// List of emojis to be displayed.
  final List<XenEmoji> animatedEmojis;

  ///
  final void Function(AnimatedEmojiData emojiData)? onEmojiSelect;

  /// The initial widget to be displayed.
  final EmojifyWidget? emojifyWidget;

  @override
  State<XenEmojify> createState() => _XenEmojifyState();
}

class _XenEmojifyState extends State<XenEmojify>
    with
        XenEmojifyAnimationMixin,
        XenEmojifyControllerMixin,
        TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    initializeAnimationControllers(
      this,
      widget.animatedEmojis.length,
    );
    initialize();
  }

  @override
  void dispose() {
    disposeAnimationControllers();
    disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: xenEmojifyLayerLink,
      key: selectedWidgetKey,
      child: Material(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(32),
        child: InkWell(
          onTap: showDock,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: currentEmoji != null
                ? AnimatedEmoji(currentEmoji!)
                : const Icon(Icons.add_circle_outline_rounded),
          ),
        ),
      ),
    );
  }
}
