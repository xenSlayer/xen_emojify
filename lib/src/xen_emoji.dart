// BSD License. Copyright © Kiran Paudel. All rights reserved

import 'package:flutter/widgets.dart';
import 'package:xen_emojify/xen_emojify.dart';

///
class XenEmoji<T> {
  ///
  const XenEmoji({required this.animatedEmoji, this.emojiName, this.emojiID})
      : assert(
          animatedEmoji is Widget || animatedEmoji is AnimatedEmojiData,
          "animatedEmoji must be of type Widget or AnimatedEmojiData",
        );

  /// Animated emoji Data or any other widget
  final T animatedEmoji;

  ///
  final String? emojiName;

  ///
  final String? emojiID;
}
