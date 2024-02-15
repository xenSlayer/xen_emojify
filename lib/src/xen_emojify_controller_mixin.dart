// BSD License. Copyright © Kiran Paudel. All rights reserved

import 'package:flutter/material.dart';
import 'package:xen_emojify/xen_emojify.dart';

/// A mixin for commonly used calculator behaviors
mixin XenEmojifyControllerMixin on State<XenEmojify> {
  /// The layer link
  late final LayerLink xenEmojifyLayerLink;

  ///
  XenEmoji? currentEmoji;

  ///
  late OverlayPortalController dockController;

  ///
  void initialize() {
    xenEmojifyLayerLink = LayerLink();
    dockController = OverlayPortalController();
  }

  ///
  Offset setXenEmojifyPosition() {
    final dockSize = widget.customDock?.dockSize;
    final s = context.findAncestorWidgetOfExactType<XenEmojifyDock>();
    print(s);
    if (dockSize != null) {
      return Offset(-dockSize.width / 2, -dockSize.height - 10);
    }
    return const Offset(0, 0);
  }

  /// Show the dock
  void toggleDock() {
    dockController.show();
  }

  /// Set the current emoji
  void setCurrentEmoji(XenEmoji emojiData) {
    setState(() {
      currentEmoji = emojiData;
      print('set emoji');
    });
    dockController.hide();
  }
}
