// BSD License. Copyright © Kiran Paudel. All rights reserved

import 'package:flutter/animation.dart';

///
mixin HoveredEmojiAnimationMixin {
  ///
  late List<AnimationController> zoomControllers;

  ///
  late List<Animation<double>> zoomAnimations;

  ///
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

  ///
  void disposeControllers() {
    for (final controller in zoomControllers) {
      controller.dispose();
    }
  }
}
