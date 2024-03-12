// BSD License. Copyright © Kiran Paudel. All rights reserved

import 'package:flutter/material.dart';
import 'package:xen_emojify/src/animations/_hovered_emoji_animation_mixin.dart';
import 'package:xen_emojify/src/provider/xen_emojify_provider.dart';
import 'package:xen_emojify/xen_emojify.dart';

/// The dock that displays list of [XenEmoji].
/// This widget pops up when the user taps on the [XenEmojify] widget.
/// The user can select an [XenEmoji] from the dock.
///
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
  /// defaults: `Color.fromARGB(200, 37, 17, 17)`
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
  final SetEmoji? onEmojiSelect;

  @override
  State<XenEmojifyDock> createState() => _XenEmojifyDockState();
}

class _XenEmojifyDockState extends State<XenEmojifyDock>
    with HoveredEmojiAnimationMixin, TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    init(this, widget.xenEmojis.length);
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

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
        itemBuilder: (context, index) {
          return MouseRegion(
            onEnter: (_) => zoomControllers[index].forward(),
            onExit: (_) => zoomControllers[index].reverse(),
            child: AnimatedBuilder(
              animation: zoomAnimations[index],
              builder: (context, child) {
                return Tooltip(
                  message: widget.xenEmojis[index].label,
                  child: GestureDetector(
                    onTap: () => _handleOnTap(context, index),
                    child: LottieSource.build(
                      src: LottieSource.network,
                      url: widget.xenEmojis[index].lottie,
                      size: Size(
                        zoomAnimations[index].value,
                        zoomAnimations[index].value,
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _handleOnTap(BuildContext context, int index) {
    final xenEmojify = XenEmojifyProvider.of(context);
    xenEmojify.setCurrentEmoji(widget.xenEmojis[index]);
    widget.onEmojiSelect?.call(widget.xenEmojis[index]);
    xenEmojify.hideDock();
    xenEmojify.selectedEmojiAnimation.animate();
  }
}
