// BSD License. Copyright © Kiran Paudel. All rights reserved

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:xen_emojify/src/enums.dart';
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
    this.lottieSource = LottieSource.network,
    this.selectedEmojiSize = 40,
    this.emojifyWidget,
    this.onEmojiSelect,
    this.customDock,
  });

  /// List of emojis to be displayed.
  final List<XenEmoji> xenEmojis;

  /// The source of the lottie file.
  final LottieSource lottieSource;

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
    initializeAnimationControllers(this, widget.xenEmojis.length);
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

    return OverlayPortal(
      controller: dockController,
      overlayChildBuilder: (context) {
        return CompositedTransformFollower(
          offset: setXenEmojifyPosition(),
          link: xenEmojifyLayerLink,
          child: Stack(
            alignment: Alignment.center,
            children: [
              const XenEmojifyDock(),
              ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => LottieSource.build(
                  widget.lottieSource,
                  widget.xenEmojis[index].lottie,
                ),
              ),
            ],
          ),
        );
      },
      child: Stack(
        children: [
          ColoredBox(
            color: Colors.black.withOpacity(0.2),
            child: SizedBox.fromSize(
              size: size,
              child: GestureDetector(onTap: dockController.hide),
            ),
          ),
          CompositedTransformTarget(
            link: xenEmojifyLayerLink,
            child: InkWell(
              highlightColor: Colors.amber,
              borderRadius: BorderRadius.circular(32),
              onTap: toggleDock,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: LottieBuilder(
                  height: 30,
                  width: 30,
                  lottie: NetworkLottie(
                      'https://fonts.gstatic.com/s/e/notoemoji/latest/1f606/lottie.json'),
                ),
              ),
            ),
          ),
        ],
      ),
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
