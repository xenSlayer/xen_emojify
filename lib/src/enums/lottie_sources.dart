// BSD License. Copyright © Kiran Paudel. All rights reserved

import 'package:lottie/lottie.dart';

///
enum LottieSource {
  /// Lottie source from assets
  asset,

  /// Lottie source from network
  network,

  /// Lottie source from file.
  file,
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
    double? height,
    double? width,
  }) {
    return switch (src) {
      LottieSource.asset => LottieBuilder.asset(
          url,
          height: height,
          width: width,
          repeat: false,
        ),
      LottieSource.network => LottieBuilder.network(
          url,
          height: height,
          width: width,
          repeat: false,
        ),
      LottieSource.file => throw UnimplementedError()
    };
  }
}
