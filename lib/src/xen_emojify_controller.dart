// BSD License. Copyright © Kiran Paudel. All rights reserved

import 'package:flutter/material.dart';
import 'package:xen_emojify/xen_emojify.dart';

/// A mixin for commonly used calculator behaviors
mixin XenEmojifyController on State<XenEmojify> {
  /// The layer link
  late final LayerLink xenEmojifyLayerLink;

  ///
  XenEmoji? currentEmoji;

  ///
  late final OverlayPortalController dockController;

  ///
  void initialize() {
    xenEmojifyLayerLink = LayerLink();
    dockController = OverlayPortalController();
  }

  ///
  Offset setXenEmojifyPosition() {
    final dockSize = widget.xenEmojifyDock.dockSize;
    return Offset(-dockSize.width / 2, -dockSize.height - 10);
  }

  /// Show the dock
  void toggleDock() {
    dockController.show();
  }

  /// Set the current emoji
  void setCurrentEmoji(XenEmoji emojiData) {
    setState(() => currentEmoji = emojiData);
    dockController.hide();
  }
}
