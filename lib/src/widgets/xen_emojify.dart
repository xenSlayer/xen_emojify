// BSD License. Copyright © Kiran Paudel. All rights reserved

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:xen_emojify/src/animations/_selected_emoji_animation_mixin.dart';
import 'package:xen_emojify/src/provider/xen_emojify_provider.dart';
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
    required this.child,
    this.initialEmoji,
    this.lottieSource = LottieSource.network,
    this.displayLabel = true,
    this.selectedEmojiSize = 40,
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

  /// Whether to show the name of the selected emoji.
  /// If true, the name of the selected emoji will be displayed.
  ///
  /// Defaults to true.
  final bool displayLabel;

  /// The size of the selected emoji.
  ///
  /// Defaults to 40.
  final double selectedEmojiSize;

  /// The initial widget to be displayed.
  final Widget? child;

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
    with SelectedEmojiAnimationMixin, TickerProviderStateMixin {
  late final LayerLink _dockLayerLink;
  late final OverlayPortalController dockController;
  XenEmoji? currentEmoji;

  @override
  void initState() {
    super.initState();
    initController(this);
    dockController = OverlayPortalController();
    _dockLayerLink = LayerLink();
    _setCurrentEmoji(widget.initialEmoji);
  }

  @override
  void dispose() {
    disposeAnimation();
    if (dockController.isShowing) {
      dockController.hide();
    }
    super.dispose();
  }

  Offset calculateDockPosition() {
    return Offset(-widget.xenEmojifyDock.dockSize.width / 2 + 10, -80);
  }

  void _setCurrentEmoji(XenEmoji? emoji) {
    setState(() => currentEmoji = emoji);
  }

  @override
  Widget build(BuildContext context) {
    return XenEmojifyProvider(
      dockController: dockController,
      currentEmoji: widget.initialEmoji ?? currentEmoji,
      // selectedEmojiController: selectedEmojiController,
      setCurrentEmoji: _setCurrentEmoji,
      child: OverlayPortal(
        controller: dockController,
        overlayChildBuilder: (context) {
          return CompositedTransformFollower(
            link: _dockLayerLink,
            showWhenUnlinked: false,
            offset: calculateDockPosition(),
            child: Stack(children: [widget.xenEmojifyDock]),
          );
        },
        child: CompositedTransformTarget(
          link: _dockLayerLink,
          child: Tooltip(
            message: currentEmoji?.label ?? '',
            child: InkWell(
              highlightColor: Colors.amber,
              borderRadius: BorderRadius.circular(32),
              onTap: dockController.show,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: currentEmoji == null
                    ? widget.child
                    : Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          AnimatedBuilder(
                            animation: selectedEmojiAnimation,
                            builder: (context, child) {
                              print(selectedEmojiAnimation.value);
                              return Lottie.network(
                                currentEmoji!.lottie,
                                height: 30,
                                width: 30,
                              );
                            },
                          ),
                          if (widget.displayLabel) _labelBuilder()
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _labelBuilder() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(
        currentEmoji!.label!,
        style: widget.selectedEmojiTextStyle,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
