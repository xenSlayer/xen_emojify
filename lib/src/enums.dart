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
  static LottieBuilder build(LottieSource src, String url) {
    return switch (src) {
      LottieSource.asset => LottieBuilder.asset(url),
      LottieSource.network => LottieBuilder.network(url),
      LottieSource.file => LottieBuilder.file(url),
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
