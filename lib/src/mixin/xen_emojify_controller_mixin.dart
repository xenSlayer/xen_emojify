// BSD License. Copyright © Kiran Paudel. All rights reserved

import 'package:flutter/material.dart';
import 'package:xen_emojify/src/enums.dart';
import 'package:xen_emojify/xen_emojify.dart';

/// A mixin for commonly used calculator behaviors
mixin XenEmojifyControllerMixin<T> on State<XenEmojify> {
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
    return Offset(-dockSize.width / 2.5, -dockSize.height);
  }

  ///
  void showDock() {
    setState(() {
      dockState = XenDockStates.mounted;
    });
    dockController.show();
  }

  ///
  void hideDock() {
    setState(() {
      dockState = XenDockStates.hidden;
    });
    dockController.hide();
  }

  /// Set the current emoji
  void setCurrentEmoji(XenEmoji emojiData) {
    setState(() => currentEmoji = emojiData);
    dockController.hide();
  }
}
