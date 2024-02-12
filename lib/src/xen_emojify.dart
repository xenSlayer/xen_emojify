// BSD License. Copyright © Kiran Paudel. All rights reserved

import 'package:animated_emoji/animated_emoji.dart';
import 'package:flutter/material.dart';
import 'package:xen_emojify/src/xen_emojify_dock.dart';

/// [XenEmojify] is a widget that allows you to display emojis

class EmojifyWidget extends StatelessWidget {
  ///
  EmojifyWidget({
    required this.xenEmojifyDock,
    this.onTap,
    this.padding = const EdgeInsets.all(8.0),
    this.defaultWidget = const Icon(Icons.add_circle_outline_rounded),
  });

  /// The dock to be displayed when tapped
  ///
  /// contains the list of emojis
  final XenEmojifyDock xenEmojifyDock;

  /// Perform certain action when tapped
  ///
  /// Like calling other methods
  final VoidCallback? onTap;

  /// The padding around the main selection widget and the placeholder
  ///
  /// default: [EdgeInsets.all(8.0)]
  final EdgeInsetsGeometry padding;

  /// The default widget to be displayed
  ///
  /// Example a button or a text
  ///
  /// default: [Icon(Icons.add_circle_outline_rounded)]
  final Widget defaultWidget;

  final _borderRadius = BorderRadius.circular(32);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey[200],
      borderRadius: _borderRadius,
      child: InkWell(
        borderRadius: _borderRadius,
        onTap: onTap,
        child: Padding(padding: padding, child: defaultWidget),
      ),
    );
  }
}

///
class XenEmojify extends StatefulWidget {
  /// [XenEmojify] is a widget that allows you to display emojis
  const XenEmojify({required this.xenEmojifyDock, this.emojifyWidget});

  ///
  final XenEmojifyDock xenEmojifyDock;

  /// The initial widget to be displayed
  final EmojifyWidget? emojifyWidget;

  @override
  State<XenEmojify> createState() => _XenEmojifyState();
}

class _XenEmojifyState extends State<XenEmojify> {
  late LayerLink layerLink;
  late GlobalKey selectedWidgetKey;
  late GlobalKey reactionWidgetKey;
  late OverlayEntry? overlayEntry;
  late Offset overlayOffset;

  @override
  void initState() {
    super.initState();
    selectedWidgetKey = GlobalKey();
    reactionWidgetKey = GlobalKey();
    layerLink = LayerLink();
  }

  void _calculatePosition() {
    if (selectedWidgetKey.currentContext != null) {
      final renderBox =
          selectedWidgetKey.currentContext!.findRenderObject()! as RenderBox;
      overlayOffset = renderBox.localToGlobal(Offset.zero);
    }
  }

  void _showDock() {
    _calculatePosition();
    final overlayState = Overlay.of(context);
    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: overlayOffset.dx - 500 / 2,
        top: overlayOffset.dy - 120,
        child: CompositedTransformFollower(
          link: layerLink,
          child: widget.xenEmojifyDock,
        ),
      ),
    );
    overlayState.insert(overlayEntry!);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: selectedWidgetKey,
      child: widget.emojifyWidget ??
          EmojifyWidget(
            onTap: _showDock,
            xenEmojifyDock: widget.xenEmojifyDock,
          ),
    );
  }
}

///
class ReactionButton extends StatefulWidget {
  ///
  const ReactionButton({
    required this.reactions,
    super.key,
    this.onSelect,
    this.defaultWidget,
  });

  ///
  final List<AnimatedEmojiData> reactions;

  ///
  final void Function(String id)? onSelect;

  ///
  final Widget? defaultWidget;

  @override
  State<ReactionButton> createState() => _ReactionButtonState();
}

class _ReactionButtonState extends State<ReactionButton>
    with TickerProviderStateMixin {
  late List<AnimationController> _zoomControllers;
  late List<Animation<double>> _zoomAnimations;
  late AnimationController _selectedEmojiController;
  late Animation<double> _selectedEmojiAnimation;

  late LayerLink layerLink;
  late GlobalKey selectedWidgetKey;
  late GlobalKey reactionWidgetKey;
  late OverlayEntry? overlayEntry;
  late Offset overlayOffset;

  final _reactionWidgetHeight = 100.0;
  final _reactionWidgetWidth = 500.0;

  dynamic _selectedEmoji;

  @override
  void initState() {
    super.initState();
    _selectedEmoji = Container(
      decoration:
          const BoxDecoration(color: Colors.white10, shape: BoxShape.circle),
      child: const Icon(Icons.add_to_photos_rounded, size: 16),
    );

    _zoomControllers = List.generate(widget.reactions.length, (index) {
      return AnimationController(
          vsync: this, duration: const Duration(milliseconds: 100));
    });

    _zoomAnimations = _zoomControllers.map((controller) {
      return Tween<double>(begin: 50, end: 90).animate(controller);
    }).toList();

    _selectedEmojiController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );
    _animateSelectedEmoji();
    selectedWidgetKey = GlobalKey();
    reactionWidgetKey = GlobalKey();
    layerLink = LayerLink();
  }

  void _animateSelectedEmoji() {
    _selectedEmojiAnimation = CurvedAnimation(
      parent: _selectedEmojiController,
      curve: Curves.easeInOutCubic,
    ).drive(
      TweenSequence<double>([
        TweenSequenceItem(
          tween: Tween<double>(begin: 0.2, end: 1.2),
          weight: 2,
        ),
        TweenSequenceItem(
          tween: Tween<double>(begin: 1.2, end: 4),
          weight: 8,
        ),
        TweenSequenceItem(
          tween: Tween<double>(begin: 4, end: 1.2),
          weight: 1,
        ),
      ]),
    );
  }

  void _calculatePosition() {
    if (selectedWidgetKey.currentContext != null) {
      final renderBox =
          selectedWidgetKey.currentContext!.findRenderObject()! as RenderBox;
      overlayOffset = renderBox.localToGlobal(Offset.zero);
    }
  }

  void showReactionOverlay() {
    _calculatePosition();
    final overlayState = Overlay.of(context);
    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: overlayOffset.dx - 500 / 2,
        top: overlayOffset.dy - 120,
        child: CompositedTransformFollower(
          link: layerLink,
          child: _reactions(),
        ),
      ),
    );
    overlayState.insert(overlayEntry!);
  }

  void hideReactionOverlay() {
    overlayEntry!.remove();
  }

  @override
  void dispose() {
    for (final controller in _zoomControllers) {
      controller.dispose();
    }
    _selectedEmojiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: showReactionOverlay,
        child: MouseRegion(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Container(
              //   key: selectedWidgetKey,
              //   width: 45,
              //   height: 45,
              //   decoration: const BoxDecoration(
              //        shape: BoxShape.circle),
              // ),
              AnimatedBuilder(
                animation: _selectedEmojiAnimation,
                builder: (context, child) {
                  if (_selectedEmoji.runtimeType == Container) {
                    return _selectedEmoji as Widget;
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Transform.scale(
                        scale: _selectedEmojiAnimation.value,
                        child: AnimatedEmoji(
                          _selectedEmoji as AnimatedEmojiData,
                          repeat: true,
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _reactions() {
    return Container(
      width: _reactionWidgetWidth,
      height: _reactionWidgetHeight,
      decoration: BoxDecoration(
        color: const Color.fromARGB(201, 255, 255, 255),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(10),
        children: [
          for (final (index, reaction) in widget.reactions.indexed)
            MouseRegion(
              onEnter: (x) => _zoomControllers[index].forward(),
              onExit: (x) => _zoomControllers[index].reverse(),
              child: AnimatedBuilder(
                animation: _zoomAnimations[index],
                builder: (context, child) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedEmoji = reaction;
                      });
                      hideReactionOverlay();
                      _selectedEmojiController
                        ..reset()
                        ..forward();
                    },
                    child: AnimatedEmoji(
                      reaction,
                      size: _zoomAnimations[index].value,
                      // repeat: false,
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
