// BSD License. Copyright © Kiran Paudel. All rights reserved

import 'dart:ui';

import 'package:lottie/lottie.dart';

///
enum LottieSource {
  /// Lottie source from assets
  asset,

  /// Lottie source from network
  network,
  ;

  const LottieSource();

  /// Builds a [LottieBuilder] based on the [LottieSource].
  ///
  /// The [url] is the path to the lottie file.
  ///
  /// The [height] and [width] are the dimensions of the lottie.
  ///
  /// The [repeat] is the repeat mode of the lottie.
  static LottieBuilder build({
    required LottieSource src,
    required String url,
    Size? size,
  }) {
    return switch (src) {
      LottieSource.asset => LottieBuilder.asset(
          url,
          height: size?.height,
          width: size?.width,
          repeat: false,
        ),
      LottieSource.network => LottieBuilder.network(
          url,
          height: size?.height,
          width: size?.width,
          repeat: false,
        ),
    };
  }
}
