// BSD License. Copyright © Kiran Paudel. All rights reserved

import 'package:flutter/material.dart';
import 'package:xen_emojify/src/provider/xen_emojify_provider.dart';
import 'package:xen_emojify/xen_emojify.dart';

part 'package:xen_emojify/src/widgets/xen_emojify_dock.dart';

mixin _HoveredEmojiAnimationMixin {
  late List<AnimationController> zoomControllers;
  late List<Animation<double>> zoomAnimations;

  void init(TickerProvider vsync, int emojiCount) {
    zoomControllers = List.generate(
      emojiCount,
      (index) {
        return AnimationController(
          vsync: vsync,
          duration: const Duration(milliseconds: 100),
        );
      },
    );

    zoomAnimations = [
      for (final controller in zoomControllers)
        Tween<double>(begin: 50, end: 90).animate(controller)
    ];
  }

  void disposeControllers() {
    for (final controller in zoomControllers) {
      controller.dispose();
    }
  }
}
