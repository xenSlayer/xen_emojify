# **xen_emojify**

[![license](https://img.shields.io/badge/licence-BSD-white.svg)](https://github.com/xenSlayer/xen_emojify/blob/master/LICENSE)
[![Stars](https://img.shields.io/github/stars/xenSlayer/xen_emojify)](https://github.com/xenSlayer/xen_emojify)
[![effective dart](https://img.shields.io/badge/style-effective_dart-40c4ff.svg)](https://dart.dev/guides/language/effective-dart)


⚠️BEFORE STARTING READ:<a href="https://github.com/xvrh/lottie-flutter/blob/master/LICENSE"> **LOTTIE LICENSE** </a>

****

## TRY DEMO
<hr><br>

<iframe src="https://xenslayer.github.io/xen_emojify/" width="100%" height="400"></iframe>

<hr><br>

<img src="misc/xen-emojify.gif"><hr>

xen_emojify is a versatile Flutter package designed to enhance user interaction by providing a rich and engaging way to display Facebook-like reactions within your app. Leveraging the power of <a href='https://pub.dev/packages/lottie'>Lottie</a>, a dynamic animation library, this package delivers seamless and visually stunning animations, ensuring a delightful user experience.

With xen_emojify, you can easily integrate a customizable reaction widget into your Flutter app, offering users a range of expressive reactions such as like, love, laugh, and more. This widget is highly customizable, allowing you to adjust its size, color scheme, and animation speed to suit your app's design and branding.

Whether you're developing a social media platform, a content-sharing app, or any other application that benefits from user feedback, xen_emojify provides a seamless solution for implementing reaction functionality. Engage your users and add a touch of personality to your app with xen_emojify.


## Features

1. Displays like, love, laugh, and other reaction icons.
2. Customizable size, color, and animation speed.
3. Supports onTap callbacks for handling user interactions.

<br>

<a href="https://www.buymeacoffee.com/kiranpaudel1892" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" style="height: 60px !important;width: 217px !important;" ></a>

## FREE LOTTIES

1. <a href="https://googlefonts.github.io/noto-emoji-animation/"> **Noto Animated Emoji** </a>
2. <a href="https://iconscout.com/lottie-animations">**IconScout**</a>


## Getting started
In your pubspec.yaml file, add the following dependency:
```
dependencies:
    xen_emojify: {latest_version}
```


## Import the xen_emojify package

```
import 'package:xen_emojify/xen_emojify.dart';
```
<hr>

## Example Usage

```
import 'package:flutter/material.dart';
import 'package:xen_emojify/xen_emojify.dart';

class XenEmojifyExample extends StatelessWidget {
  const XenEmojifyExample({super.key});

  @override
  Widget build(BuildContext context) {
    final lottie = [
      const XenEmoji(
        'https://fonts.gstatic.com/s/e/notoemoji/latest/1f60d/lottie.json',
        lottieName: 'heart',
        lottieID: '1f60d',
      ),
      const XenEmoji(
        'https://fonts.gstatic.com/s/e/notoemoji/latest/1f606/lottie.json',
        lottieName: 'laughing',
        lottieID: '1f606',
      ),
      const XenEmoji(
        'https://fonts.gstatic.com/s/e/notoemoji/latest/1f60e/lottie.json',
        lottieName: 'sunglasses',
        lottieID: '1f60e',
      ),
    ];

    return Scaffold(
      body: ListView(
        children: [
          Center(
            child: XenEmojify(
              lottieSource: LottieSource.network,
              selectedEmojiSize: 10,
              xenEmojifyDock: XenEmojifyDock(
                xenEmojis: lottie,
                onEmojiSelect: print,
              ),
              initialEmoji: lottie[1],
            ),
          ),
        ],
      ),
    );
  }
}

```
