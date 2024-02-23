// BSD License. Copyright © Kiran Paudel. All rights reserved

// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:xen_emojify/src/enums/enums.dart';
import 'package:xen_emojify/xen_emojify.dart';

mixin XenEmojifyControllerMixin {
  late final LayerLink xenEmojifyLayerLink;

  late StreamController<XenEmoji> currentEmojiStreamController;

  XenDockStates dockState = XenDockStates.hidden;

  late final OverlayPortalController dockController;

  void initializeXenEmojifyControllers() {
    xenEmojifyLayerLink = LayerLink();
    dockController = OverlayPortalController();
    currentEmojiStreamController = StreamController<XenEmoji>.broadcast();
  }

  Offset dockPosition(XenEmojifyDock dock) {
    final dockSize = dock.dockSize;
    return Offset(-dockSize.width / 2.5, -dockSize.height);
  }

  void showDock() {
    dockController.show();
  }

  void disposeXenEmojifyControllers() {
    currentEmojiStreamController.close();
  }

  void hideDock() {
    dockController.hide();
  }

  // void toggleDock() {
  //   if (dockState == XenDockStates.mounted) {
  //     hideDock();
  //   } else {
  //     showDock();
  //   }
  // }

  void setCurrentEmoji(XenEmoji emojiData) {
    currentEmojiStreamController.add(emojiData);
    dockController.hide();
  }
}
