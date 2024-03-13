# **xen_emojify**

[![license](https://img.shields.io/badge/licence-BSD-white.svg)](https://github.com/xenSlayer/xen_emojify/blob/master/LICENSE)
[![Stars](https://img.shields.io/github/stars/xenSlayer/xen_emojify)](https://github.com/xenSlayer/xen_emojify)
[![effective dart](https://img.shields.io/badge/style-effective_dart-40c4ff.svg)](https://dart.dev/guides/language/effective-dart)


## ⚠️BEFORE STARTING READ:<a href="https://github.com/xvrh/lottie-flutter/blob/master/LICENSE" target="_blank"> **LOTTIE LICENSE** </a>


## <a href="https://xenslayer.github.io/xen_emojify/" target="_blank"> TRY WEB DEMO
</a>


<img src="misc/xen-emojify.gif"><hr>

xen_emojify is a versatile Flutter package designed to enhance user interaction by providing a rich and engaging way to display Facebook-like reactions within your app. Leveraging the power of <a href='https://pub.dev/packages/lottie' target="_blank">Lottie</a>, a dynamic animation library, this package delivers seamless and visually stunning animations, ensuring a delightful user experience.

With xen_emojify, you can easily integrate a customizable reaction widget into your Flutter app, offering users a range of expressive reactions such as like, love, laugh, and more. This widget is highly customizable, allowing you to adjust its size, color scheme, and animation speed to suit your app's design and branding.

Whether you're developing a social media platform, a content-sharing app, or any other application that benefits from user feedback, xen_emojify provides a seamless solution for implementing reaction functionality. Engage your users and add a touch of personality to your app with xen_emojify.


## Features

1. Displays like, love, laugh, and other reaction icons.
2. Customizable size, color, and animation speed.
3. Supports onTap callbacks for handling user interactions.

<br>

<a href="https://www.buymeacoffee.com/kiranpaudel1892" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" style="height: 60px !important;width: 217px !important;" ></a>

## FREE LOTTIES

1. <a href="https://googlefonts.github.io/noto-emoji-animation/" target="_blank"> **Noto Animated Emoji** </a>
2. <a href="https://iconscout.com/lottie-animations" target="_blank">**IconScout**</a>


## Getting started
In your pubspec.yaml file, add the following dependency:
```yaml
dependencies:
    xen_emojify: current_version
```


## Import the xen_emojify package

```dart
import 'package:xen_emojify/xen_emojify.dart';
```
<hr>

## Example Usage

```dart
  XenEmoji initialEmoji = const XenEmoji(
      'https://fonts.gstatic.com/s/e/notoemoji/latest/1f60d/lottie.json',
      label: 'heart eyes',
      lottieID: '1f60d',
    );


    final xenEmojifyWidget = XenEmojify(
      lottieSource: LottieSources.network,
      displayLabel: true,
      initialEmoji: initialEmoji,
      xenEmojifyDock: XenEmojifyDock(
        dockColor: Colors.amber.withOpacity(0.7),
        onEmojiSelect: (emoji) {
          setState(() => initialEmoji = emoji);
        },
        xenEmojis: const [
          XenEmoji(
            'https://fonts.gstatic.com/s/e/notoemoji/latest/1f60d/lottie.json',
            label: 'Heart Eyes',
            lottieID: '1f60d',
          ),
        ],
      ),
    );
```
