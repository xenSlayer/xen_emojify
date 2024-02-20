// BSD License. Copyright © Kiran Paudel. All rights reserved

import 'package:flutter/material.dart';

import 'package:xen_emojify/src/enums.dart';
import 'package:xen_emojify/src/mixin/xen_emojify_animation_mixin.dart';
import 'package:xen_emojify/src/mixin/xen_emojify_controller_mixin.dart';
import 'package:xen_emojify/src/xen_emoji.dart';
import 'package:xen_emojify/src/xen_emojify_dock.dart';
import 'package:xen_emojify/src/xen_emojify_widget.dart';

///
class XenEmojify extends StatefulWidget {
  /// [XenEmojify] is a widget that allows you to display emojis.
  const XenEmojify({
    required this.xenEmojifyDock,
    this.initialEmoji,
    this.lottieSource = LottieSource.network,
    this.selectedEmojiSize = 40,
    this.emojifyWidget,
  });

  ///
  final XenEmojifyDock xenEmojifyDock;

  ///
  final XenEmoji? initialEmoji;

  /// The source of the lottie file.
  final LottieSource lottieSource;

  /// The size of the selected emoji.
  final double selectedEmojiSize;

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
  ///
  late final AnimationController selectedEmojiController;

  ///
  late final Animation<double> selectedEmojiAnimation;

  @override
  void initState() {
    super.initState();
    initialize();
    selectedEmojiController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );

    selectedEmojiAnimation = CurvedAnimation(
      parent: selectedEmojiController,
      curve: Curves.easeInOutCubic,
    ).drive(
      TweenSequence<double>(
        [
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
        ],
      ),
    );
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
        SizedBox.fromSize(
          size: size,
          child: GestureDetector(onTap: hideDock),
        ),
        OverlayPortal(
          controller: dockController,
          overlayChildBuilder: (context) {
            return CompositedTransformFollower(
              link: xenEmojifyLayerLink,
              offset: dockPosition(),
              child: Stack(
                children: [
                  widget.xenEmojifyDock,
                ],
              ),
            );
          },
          child: CompositedTransformTarget(
            link: xenEmojifyLayerLink,
            child: InkWell(
              highlightColor: Colors.amber,
              borderRadius: BorderRadius.circular(32),
              onTap: showDock,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    _emojiBuilder(widget.initialEmoji ?? currentEmoji!,
                        widget.emojifyWidget, widget.selectedEmojiSize),
                    const SizedBox(width: 8),
                    const Text('EMOJI')
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _emojiBuilder(
      XenEmoji? emoji, EmojifyWidget? emojifyWidget, double? size) {
    if (emoji != null) {
      return SizedBox(
        width: 30,
        height: 30,
        child: LottieSource.build(
          src: emoji.lottieSource ?? widget.lottieSource,
          url: emoji.lottie,
          height: size,
          width: size,
        ),
      );
    }
    return emojifyWidget ?? EmojifyWidget();
  }
}

///
class LottieLoadErrorBuilder extends StatelessWidget {
  ///
  const LottieLoadErrorBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('error loading lottie');
  }
}
