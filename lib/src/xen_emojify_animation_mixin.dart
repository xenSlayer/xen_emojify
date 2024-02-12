// BSD License. Copyright © Kiran Paudel. All rights reserved
// Define a mixin for commonly used animation behaviors
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

mixin XenEmojifyAnimationMixin on State {
  late List<AnimationController> zoomControllers;
  late List<Animation<double>> zoomAnimations;

  late AnimationController selectedEmojiController;
  late Animation<double> selectedEmojiAnimation;

  void animateSelectedEmoji() {
    selectedEmojiAnimation = CurvedAnimation(
      parent: selectedEmojiController,
      curve: Curves.easeInOutCubic,
    ).drive(
      TweenSequence<double>([
        TweenSequenceItem(
          tween: Tween<double>(begin: 0.2, end: 1.2),
          weight: 2,
        ),
        TweenSequenceItem(
          tween: Tween<double>(begin: 1.2, end: 4),
          weight: 8,
        ),
        TweenSequenceItem(
          tween: Tween<double>(begin: 4, end: 1.2),
          weight: 1,
        ),
      ]),
    );
  }

  @mustCallSuper
  void initializeControllers(TickerProvider vsync, int emojiCount) {
    zoomControllers = List.generate(emojiCount, (index) {
      return AnimationController(
        vsync: vsync,
        duration: const Duration(milliseconds: 100),
      );
    });

    zoomAnimations = zoomControllers.map((controller) {
      return Tween<double>(begin: 50, end: 90).animate(controller);
    }).toList();

    selectedEmojiController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 650),
    );
  }

  @override
  void dispose() {
    for (final controller in zoomControllers) {
      controller.dispose();
    }
    selectedEmojiController.dispose();
    super.dispose();
  }
}
