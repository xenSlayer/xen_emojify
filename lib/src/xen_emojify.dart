// BSD License. Copyright © Kiran Paudel. All rights reserved

import 'package:animated_emoji/animated_emoji.dart';
import 'package:flutter/material.dart';
import 'package:xen_emojify/src/xen_emoji.dart';
import 'package:xen_emojify/src/xen_emojify_animation_mixin.dart';
import 'package:xen_emojify/src/xen_emojify_controller_mixin.dart';
import 'package:xen_emojify/src/xen_emojify_dock.dart';
import 'package:xen_emojify/src/xen_emojify_widget.dart';

///
class XenEmojify extends StatefulWidget {
  /// [XenEmojify] is a widget that allows you to display emojis.
  const XenEmojify({
    required this.xenEmojis,
    this.selectedEmojiSize = 40,
    this.emojifyWidget,
    this.onEmojiSelect,
    this.customDock,
  });

  /// List of emojis to be displayed.
  final List<XenEmoji> xenEmojis;

  /// The size of the selected emoji.
  final double selectedEmojiSize;

  ///
  final void Function(XenEmoji emoji)? onEmojiSelect;

  /// The initial widget to be displayed.
  final EmojifyWidget? emojifyWidget;

  ///
  final XenEmojifyDock? customDock;

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
      widget.xenEmojis.length,
    );
    initialize();
  }

  @override
  void dispose() {
    disposeAnimationControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Stack(
      alignment: Alignment.center,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: SizedBox.fromSize(
            size: size,
            child: GestureDetector(onTap: dockController.hide),
          ),
        ),
        OverlayPortal(
          controller: dockController,
          overlayChildBuilder: (context) {
            return CompositedTransformFollower(
              offset: setXenEmojifyPosition(),
              link: xenEmojifyLayerLink,
              child: XenEmojifyDock(
                xenEmojis: widget.xenEmojis,
                onTap: setCurrentEmoji,
              ),
            );
          },
          child: CompositedTransformTarget(
            link: xenEmojifyLayerLink,
            child: InkWell(
              highlightColor: Colors.amber,
              borderRadius: BorderRadius.circular(32),
              onTap: toggleDock,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: resolveWidget(widget.selectedEmojiSize),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget resolveWidget(double size) {
    if (currentEmoji != null) {
      if (currentEmoji?.animatedEmoji.runtimeType == Widget) {
        return currentEmoji?.animatedEmoji as Widget;
      } else {
        return AnimatedEmoji(
          currentEmoji?.animatedEmoji as AnimatedEmojiData,
          size: size,
        );
      }
    }
    return const Icon(Icons.add_circle_outline_rounded);
  }
}
