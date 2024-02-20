// BSD License. Copyright © Kiran Paudel. All rights reserved

import 'package:xen_emojify/xen_emojify.dart';

/// The data class for [XenEmoji].
class XenEmoji {
  ///
  const XenEmoji(
    this.lottie, {
    this.lottieName,
    this.lottieID,
    this.lottieSource,
  });

  /// Path to lottie file.
  ///
  /// This can be a network url, file url or asset url.
  /// 
  /// Example:
  /// 
  /// `network`: 'https://fonts.gstatic.com/s/e/notoemoji/latest/1f60e/lottie.json'
  /// 
  /// `asset`: 'assets/emoji.json'
  /// 
  /// `file`: '/path/to/emoji.json'
  final String lottie;

  /// The name of the lottie.
  ///
  /// Can be any custom name.
  /// Will be displayed next to the currently selected [XenEmoji].
  final String? lottieName;

  /// The id of the lottie.
  /// 
  /// Can be any custom id to uniquely identify the [XenEmoji].
  final String? lottieID;

  /// The source of the lottie.
  ///
  /// Can be [LottieSource.asset], [LottieSource.network] or [LottieSource.file].
  final LottieSource? lottieSource;

  @override
  String toString() {
    return 'XenEmoji(lottie: $lottie, emojiName: $lottieName, emojiID: $lottieID, lottieSource: $lottieSource)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is XenEmoji &&
        other.lottie == lottie &&
        other.lottieName == lottieName &&
        other.lottieID == lottieID &&
        other.lottieSource == lottieSource;
  }

  @override
  int get hashCode {
    return lottie.hashCode ^
        lottieName.hashCode ^
        lottieID.hashCode ^
        lottieSource.hashCode;
  }
}
