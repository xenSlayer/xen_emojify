// BSD License. Copyright © Kiran Paudel. All rights reserved

import 'package:flutter/material.dart';
import 'package:xen_emojify/src/enums.dart';
import 'package:xen_emojify/xen_emojify.dart';

/// A mixin for commonly used calculator behaviors
mixin XenEmojifyControllerMixin on State<XenEmojify> {
  /// The layer link
  late final LayerLink xenEmojifyLayerLink;

  ///
  XenEmoji? currentEmoji;

  ///
  XenDockStates dockState = XenDockStates.hidden;

  ///
  late final OverlayPortalController dockController;

  ///
  void initialize() {
    xenEmojifyLayerLink = LayerLink();
    dockController = OverlayPortalController();
  }

  ///
  Offset dockPosition() {
    final dockSize = widget.xenEmojifyDock.dockSize;
    return Offset(-dockSize.width / 2, -dockSize.height - 10);
  }

  /// Show the dock
  void toggleDock() {
    return switch (dockState) {
      XenDockStates.mounted => dockController.hide(),
      XenDockStates.hidden => dockController.show(),
    };
  }

  /// Set the current emoji
  void setCurrentEmoji(XenEmoji emojiData) {
    setState(() => currentEmoji = emojiData);
    dockController.hide();
  }
}
