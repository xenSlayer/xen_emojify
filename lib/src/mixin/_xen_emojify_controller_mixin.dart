// BSD License. Copyright © Kiran Paudel. All rights reserved

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:xen_emojify/src/enums/enums.dart';
import 'package:xen_emojify/xen_emojify.dart';

mixin XenEmojifyControllerMixin<T extends StatefulWidget> on State<T> {
  late final LayerLink xenEmojifyLayerLink;

  XenEmoji? currentEmoji;

  XenDockStates dockState = XenDockStates.hidden;

  late final OverlayPortalController dockController;

  void initialize() {
    xenEmojifyLayerLink = LayerLink();
    dockController = OverlayPortalController();
  }

  Offset dockPosition(XenEmojifyDock dock) {
    final dockSize = dock.dockSize;
    return Offset(-dockSize.width / 2.5, -dockSize.height);
  }

  void showDock() {
    dockController.show();
    setState(() => dockState = XenDockStates.mounted);
  }

  void hideDock() {
    dockController.hide();
    setState(() => dockState = XenDockStates.hidden);
  }

  void toggleDock() {
    if (dockState == XenDockStates.mounted) {
      hideDock();
    } else {
      showDock();
    }
  }

  void setCurrentEmoji(XenEmoji emojiData) {
    setState(() => currentEmoji = emojiData);
    dockController.hide();
  }
}
