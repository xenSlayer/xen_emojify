// BSD License. Copyright © Kiran Paudel. All rights reserved

import 'package:xen_emojify/xen_emojify.dart';

///
class XenEmoji {
  ///
  const XenEmoji(
    this.lottie, {
    this.emojiName,
    this.emojiID,
    this.lottieSource,
  });

  ///
  final String lottie;

  ///
  final String? emojiName;

  ///
  final String? emojiID;

  ///
  final LottieSource? lottieSource;

  @override
  String toString() {
    return 'XenEmoji(lottie: $lottie, emojiName: $emojiName, emojiID: $emojiID, lottieSource: $lottieSource)';
  }
}
