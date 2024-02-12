// BSD License. Copyright © Kiran Paudel. All rights reserved
import 'package:animated_emoji/animated_emoji.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

///
class XenEmojifyDock extends StatefulWidget {
  /// [XenEmojifyDock] is a widget that allows you to display emojis
  const XenEmojifyDock({
    required this.xenEmojis,
    this.dockColor = const Color.fromARGB(200, 37, 17, 17),
    this.dockSize = const Size(500, 80),
    this.repeatEmojiAnimation = false,
    this.onTap,
  });

  /// List of emojis to be displayed
  final List<AnimatedEmojiData> xenEmojis;

  /// The color of the dock
  /// default: [Colors.grey]
  final Color dockColor;

  /// The size of the dock
  ///
  /// default: [Size(300, 200)]
  final Size dockSize;

  /// Whether to repeat the emoji animation
  ///
  /// default: [false]
  final bool repeatEmojiAnimation;

  /// Perform certain action when tapped
  final Function(AnimatedEmojiData emojiData)? onTap;

  @override
  State<XenEmojifyDock> createState() => _XenEmojifyDockState();
}

class _XenEmojifyDockState extends State<XenEmojifyDock>
    with Diagnosticable, TickerProviderStateMixin {
  late List<AnimationController> _zoomControllers;
  late List<Animation<double>> _zoomAnimations;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
  }

  @override
  void initState() {
    _zoomControllers = List.generate(widget.xenEmojis.length, (index) {
      return AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 100),
      );
    });

    _zoomAnimations = _zoomControllers.map((controller) {
      return Tween<double>(begin: 50, end: 90).animate(controller);
    }).toList();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: FocusNode(),
      child: Container(
        width: widget.dockSize.width,
        height: widget.dockSize.height,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: widget.dockColor.withOpacity(0.5),
            borderRadius: const BorderRadius.all(Radius.circular(32)),
          ),
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(16),
            children: [
              for (final (index, reaction) in widget.xenEmojis.indexed)
                MouseRegion(
                  onEnter: (_) => _zoomControllers[index].forward(),
                  onExit: (_) => _zoomControllers[index].reverse(),
                  child: AnimatedBuilder(
                    animation: _zoomAnimations[index],
                    builder: (context, child) {
                      return GestureDetector(
                        onTap: () => widget.onTap?.call(reaction),
                        child: AnimatedEmoji(
                          reaction,
                          size: _zoomAnimations[index].value,
                          repeat: widget.repeatEmojiAnimation,
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
