// BSD License. Copyright © Kiran Paudel. All rights reserved

import 'package:flutter/material.dart';

import 'package:xen_emojify/src/mixin/_xen_emojify_animation_mixin.dart';
import 'package:xen_emojify/src/mixin/_xen_emojify_controller_mixin.dart';

import 'package:xen_emojify/src/xen_emojify_widget.dart';
import 'package:xen_emojify/xen_emojify.dart';

/// The widget that allows you to display emojis.
///
/// The [XenEmojify] widget is the main widget that allows you to display emojis.
/// If initialEmoji is not provided, the widget will display the default
/// [EmojifyWidget], unless you provide a custom [EmojifyWidget].
class XenEmojify extends StatefulWidget {
  ///
  const XenEmojify({
    required this.xenEmojifyDock,
    this.initialEmoji,
    this.lottieSource = LottieSource.network,
    this.lottieLoadErrorBuilder = const LottieLoadErrorBuilder(),
    this.selectedEmojiSize = 40,
    this.emojifyWidget,
    this.selectedEmojiTextStyle = const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w800,
    ),
  });

  /// The dock that displays list of [XenEmoji].
  final XenEmojifyDock xenEmojifyDock;

  /// The initial emoji to be displayed.
  final XenEmoji? initialEmoji;

  /// The source of the lottie file.
  final LottieSource lottieSource;

  /// The builder to be displayed when lottie file fails to load.
  ///
  /// If not provided, the default [LottieLoadErrorBuilder] will be displayed.
  final Widget lottieLoadErrorBuilder;

  /// The size of the selected emoji.
  final double selectedEmojiSize;

  /// The initial widget to be displayed.
  final EmojifyWidget? emojifyWidget;

  /// The text style of the selected emoji.
  ///
  final TextStyle selectedEmojiTextStyle;

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
    setState(() => currentEmoji = widget.initialEmoji);
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
              offset: dockPosition(widget.xenEmojifyDock),
              child: Stack(children: [widget.xenEmojifyDock]),
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
                child: currentEmoji == null
                    ? widget.emojifyWidget ?? EmojifyWidget()
                    : Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          LottieSource.build(
                            src: widget.lottieSource,
                            url: currentEmoji!.lottie,
                            height: 30,
                            width: 30,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            currentEmoji!.lottieName!,
                            style: widget.selectedEmojiTextStyle,
                          )
                        ],
                      ),
              ),
            ),
          ),
        ),
      ],
    );
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
