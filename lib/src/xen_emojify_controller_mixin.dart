// BSD License. Copyright © Kiran Paudel. All rights reserved
import 'package:animated_emoji/emojis.dart';
import 'package:flutter/material.dart';
import 'package:xen_emojify/src/xen_emojify.dart';

/// A mixin for commonly used calculator behaviors
mixin XenEmojifyControllerMixin on State<XenEmojify> {
  ///
  late LayerLink xenEmojifyLayerLink;

  ///
  late GlobalKey selectedWidgetKey;

  ///
  AnimatedEmojiData? currentEmoji;

  ///
  late GlobalKey xenEmojifyWidgetKey;
  late OverlayEntry? _overlayEntry;
  late Offset _overlayOffset;

  ///
  void initialize() {
    xenEmojifyLayerLink = LayerLink();
    selectedWidgetKey = GlobalKey();
    xenEmojifyWidgetKey = GlobalKey();
  }

  ///
  void disposeControllers() {
    _overlayEntry?.remove();
    _overlayEntry?.dispose();
  }

  ///
  void _calculatePosition() {
    if (selectedWidgetKey.currentContext != null) {
      final renderBox =
          selectedWidgetKey.currentContext!.findRenderObject()! as RenderBox;
      _overlayOffset = renderBox.localToGlobal(Offset.zero);

      final dockSize = _getDockSize(context);
      print(dockSize);

      _overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
          left: _overlayOffset.dx - (500 - 50) / 2,
          top: _overlayOffset.dy - 80 / 2 - 60,
          child: CompositedTransformFollower(
            link: xenEmojifyLayerLink,
            child: widget.xenEmojifyDock,
          ),
        ),
      );
    }
  }

  Size? _getDockSize(BuildContext context) {
    final renderObject = context.findRenderObject();
    if (renderObject is RenderBox) {
      return renderObject.size;
    }
    return null;
  }

  ///
  void showDock() {
    _calculatePosition();
    final overlayState = Overlay.of(context);
    overlayState.insert(_overlayEntry!);
  }

  ///
  void setCurrentEmoji(AnimatedEmojiData emojiData) {
    setState(() {
      currentEmoji = emojiData;
      print('fuck bastard');
    });
    widget.xenEmojifyDock.onTap?.call(emojiData);
  }
}
