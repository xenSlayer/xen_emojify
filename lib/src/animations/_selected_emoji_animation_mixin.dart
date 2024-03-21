// BSD License. Copyright © Kiran Paudel. All rights reserved

import 'package:flutter/animation.dart';

/// Zoom animation mixin for [XenEmojify].
///
/// This mixin provides the animation controllers and animations for the zoom
/// animation of the emojis in the dock.
///
/// The mixin also provides the animation controller and animation for the
/// selected emoji.
///
class SelectedEmojiAnimation {
  ///
  late final AnimationController selectedEmojiController;

  ///
  late final Animation<double> selectedEmojiAnimation;

  ///
  void initController(TickerProvider vsync) {
    selectedEmojiController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 450),
    );
    selectedEmojiAnimation = _animation();
  }

  ///
  void animate() {
    selectedEmojiController.value = 0;
    selectedEmojiController.forward();
  }

  Animation<double> _animation() {
    return TweenSequence<double>(
      [
        TweenSequenceItem(
          tween: Tween<double>(begin: 0.2, end: 1.4),
          weight: 3,
        ),
        TweenSequenceItem(
          tween: Tween<double>(begin: 1.4, end: 7),
          weight: 4,
        ),
        TweenSequenceItem(
          tween: Tween<double>(begin: 7, end: 1.4),
          weight: 1,
        ),
      ],
    ).animate(selectedEmojiController);
  }

  ///
  void disposeController() => selectedEmojiController.dispose();
}
