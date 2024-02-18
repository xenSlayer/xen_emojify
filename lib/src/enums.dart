// BSD License. Copyright © Kiran Paudel. All rights reserved

import 'package:lottie/lottie.dart';

///
enum LottieSource {
  /// Lottie source from assets
  asset,

  /// Lottie source from network
  network,

  /// Lottie source from file
  file,
  ;

  const LottieSource();

  ///
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
        ),
      LottieSource.network => LottieBuilder.network(
          url,
          height: height,
          width: width,
        ),
      LottieSource.file => LottieBuilder.file(
          url,
          height: height,
          width: width,
        ),
    };
  }
}

///
enum XenDockStates {
  /// Dock is visible
  mounted,

  /// Dock is hidden
  hidden,
  ;
}
