// BSD License. Copyright © Kiran Paudel. All rights reserved
import 'package:flutter/widgets.dart';
import 'package:xen_emojify/src/animations/_selected_emoji_animation_mixin.dart';
import 'package:xen_emojify/src/xen_emoji.dart';

/// The provider that provides the [XenEmojifyDock] with the current [XenEmoji].
///
/// The [XenEmojifyProvider] is an [InheritedWidget] that provides the [XenEmojifyDock]
/// with the current [XenEmoji] and the [SetEmoji] function to set the current [XenEmoji].
///
/// The [XenEmojifyProvider] also provides the [OverlayPortalController] to show and hide the dock.
class XenEmojifyProvider extends InheritedWidget {
  ///
  final OverlayPortalController dockController;

  ///
  final XenEmoji? currentEmoji;

  ///
  final SetEmoji setCurrentEmoji;

  ///
  final SelectedEmojiAnimation selectedEmojiAnimation;

  ///
  // final AnimationController selectedEmojiController;

  ///
  XenEmojifyProvider({
    required Widget child,
    required this.dockController,
    required this.setCurrentEmoji,
    required this.selectedEmojiAnimation,
    Key? key,
    this.currentEmoji,
  }) : super(key: key, child: child);

  ///
  static XenEmojifyProvider of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<XenEmojifyProvider>();
    if (provider == null) {
      throw FlutterError('XenEmojifyStateProvider not found in context');
    }
    return provider;
  }

  @override
  bool updateShouldNotify(XenEmojifyProvider oldWidget) {
    return currentEmoji != oldWidget.currentEmoji;
  }

  ///
  void showDock() => dockController.show();

  ///
  void hideDock() => dockController.hide();
}

/// A function signature for setting an [XenEmoji].
///
/// The function takes an [XenEmoji] as a parameter and does not return any value.
/// Usage example:
/// ```dart
/// void setEmoji(XenEmoji emoji) {}
/// ```
typedef SetEmoji = void Function(XenEmoji emoji);
