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
mixin SelectedEmojiAnimationMixin {
  ///
  late final AnimationController selectedEmojiController;

  ///
  late final Animation<double> selectedEmojiAnimation;

  ///
  void initController(TickerProvider vsync) {
    selectedEmojiController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 650),
    );

    selectedEmojiAnimation = CurvedAnimation(
      parent: selectedEmojiController,
      curve: Curves.easeInOutCubic,
    );
  }

  ///
  void animate() {
    selectedEmojiAnimation.drive(_animation());
  }

  TweenSequence _animation() {
    return TweenSequence<double>(
      [
        // TweenSequenceItem(
        //   tween: Tween<double>(begin: 0.2, end: 1.2),
        //   weight: 2,
        // ),
        // TweenSequenceItem(
        //   tween: Tween<double>(begin: 1.2, end: 4),
        //   weight: 8,
        // ),
        // TweenSequenceItem(
        //   tween: Tween<double>(begin: 4, end: 1.2),
        //   weight: 1,
        // ),
        TweenSequenceItem(
          tween: Tween<double>(begin: 20, end: 30),
          weight: 2,
        ),
        TweenSequenceItem(
          tween: Tween<double>(begin: 30, end: 25),
          weight: 8,
        ),
        TweenSequenceItem(
          tween: Tween<double>(begin: 25, end: 20),
          weight: 1,
        ),
      ],
    );
  }

  ///
  void disposeAnimation() => selectedEmojiController.dispose();
}
