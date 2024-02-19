// BSD License. Copyright © Kiran Paudel. All rights reserved

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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
    this.lottieSource = LottieSource.network,
    this.selectedEmojiSize = 40,
    this.emojifyWidget,
    this.onEmojiSelect,
  });

  ///
  final XenEmojifyDock xenEmojifyDock;

  /// The source of the lottie file.
  final LottieSource lottieSource;

  /// The size of the selected emoji.
  final double selectedEmojiSize;

  ///
  final void Function(XenEmoji emoji)? onEmojiSelect;

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
          child: GestureDetector(onTap: dockController.hide),
        ),
        OverlayPortal(
          controller: dockController,
          overlayChildBuilder: (context) {
            return CompositedTransformFollower(
              link: xenEmojifyLayerLink,
              offset: dockPosition(),
              child: widget.xenEmojifyDock,
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
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    LottieBuilder(
                      height: 30,
                      width: 30,
                      repeat: false,
                      lottie: NetworkLottie(
                        'https://fonts.gstatic.com/s/e/notoemoji/latest/1f606/lottie.json',
                      ),
                    ),
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
}

///
class LottieLoadErrorBuilder extends StatelessWidget {
  ///
  const LottieLoadErrorBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
