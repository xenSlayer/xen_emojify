// BSD License. Copyright © Kiran Paudel. All rights reserved

import 'package:animated_emoji/emojis.dart';
import 'package:flutter/material.dart';
import 'package:xen_emojify/src/xen_emojify.dart';
import 'package:xen_emojify/src/xen_emojify_dock.dart';

/// A mixin for commonly used calculator behaviors
mixin XenEmojifyControllerMixin on State<XenEmojify> {
  /// The layer link
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

      final dock = XenEmojifyDock(
        xenEmojis: widget.animatedEmojis,
        onTap: (emoji) {
          widget.onEmojiSelect?.call(emoji);
          setCurrentEmoji(emoji);
        },
      );

      _overlayEntry = OverlayEntry(
        builder: (context) => CompositedTransformFollower(
          link: xenEmojifyLayerLink,
          child: Positioned(
            right: _overlayOffset.dx - dock.dockSize.width / 2,
            top: _overlayOffset.dy - dock.dockSize.height / 2,
            child: dock,
          ),
        ),
      );
    }
  }

  Size? _getDockSize(BuildContext context) {
    final dock = context.findAncestorWidgetOfExactType<XenEmojifyDock>();
    return dock?.dockSize;
  }

  /// Show the dock
  void showDock() {
    _calculatePosition();
    final overlayState = Overlay.of(context);
    overlayState.insert(_overlayEntry!);
  }

  /// Set the current emoji
  void setCurrentEmoji(AnimatedEmojiData emojiData) {
    setState(() {
      currentEmoji = emojiData;
      print('set emoji');
    });
  }
}
