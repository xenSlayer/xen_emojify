// BSD License. Copyright © Kiran Paudel. All rights reserved

import 'package:flutter/material.dart';

import 'package:xen_emojify/src/mixin/_xen_emojify_animation_mixin.dart';
import 'package:xen_emojify/src/xen_emojify_provider.dart';

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
    this.showSelectedEmojiName = true,
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

  /// Whether to show the name of the selected emoji.
  /// If true, the name of the selected emoji will be displayed.
  ///
  /// Defaults to true.
  final bool showSelectedEmojiName;

  /// The size of the selected emoji.
  ///
  /// Defaults to 40.
  final double selectedEmojiSize;

  /// The initial widget to be displayed.
  final EmojifyWidget? emojifyWidget;

  /// The text style of the selected emoji.
  ///
  /// Defaults to:
  ///```
  /// const TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
  /// ```
  final TextStyle selectedEmojiTextStyle;

  @override
  State<XenEmojify> createState() => _XenEmojifyState();
}

class _XenEmojifyState extends State<XenEmojify>
    with XenEmojifyAnimationMixin, TickerProviderStateMixin {
  ///
  late final AnimationController selectedEmojiController;

  ///
  late final Animation<double> selectedEmojiAnimation;

  late final OverlayPortalController dockController;

  late final LayerLink dockLayerLink;

  XenEmoji? currentEmoji;

  @override
  void initState() {
    super.initState();
    initializeAnimationControllers(
      this,
      widget.xenEmojifyDock.xenEmojis.length,
    );
    dockController = OverlayPortalController();
    dockLayerLink = LayerLink();
    setCurrentEmoji(widget.initialEmoji);
  }

  @override
  void dispose() {
    disposeAnimationControllers();
    if (dockController.isShowing) {
      dockController.hide();
    }
    super.dispose();
  }

  Offset calculateDockPosition() {
    return Offset(-widget.xenEmojifyDock.dockSize.width / 2 + 10, -80);
  }

  void setCurrentEmoji(XenEmoji? emoji) => setState(() => currentEmoji = emoji);

  @override
  Widget build(BuildContext context) {
    return XenEmojifyProvider(
      dockController: dockController,
      currentEmoji: widget.initialEmoji ?? currentEmoji,
      setCurrentEmoji: setCurrentEmoji,
      child: OverlayPortal(
        controller: dockController,
        overlayChildBuilder: (context) {
          return CompositedTransformFollower(
            link: dockLayerLink,
            showWhenUnlinked: false,
            offset: calculateDockPosition(),
            child: Stack(children: [widget.xenEmojifyDock]),
          );
        },
        child: CompositedTransformTarget(
          link: dockLayerLink,
          child: InkWell(
            highlightColor: Colors.amber,
            borderRadius: BorderRadius.circular(32),
            onTap: dockController.show,
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
                        if (widget.showSelectedEmojiName)
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              currentEmoji!.lottieName!,
                              style: widget.selectedEmojiTextStyle,
                            ),
                          )
                      ],
                    ),
            ),
          ),
        ),
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
    return const Text('error loading lottie');
  }
}
