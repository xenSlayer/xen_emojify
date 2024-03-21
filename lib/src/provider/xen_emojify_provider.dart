// BSD License. Copyright © Kiran Paudel. All rights reserved
import 'package:flutter/widgets.dart';
import 'package:xen_emojify/src/animations/_selected_emoji_animation_mixin.dart';
import 'package:xen_emojify/src/xen_emoji.dart';

/// A function signature for setting an [XenEmoji].
///
/// The function takes an [XenEmoji] as a parameter and does not return any value.
/// Usage example:
/// ```dart
/// void setEmoji(XenEmoji emoji) {}
/// ```
typedef SetEmoji = void Function(XenEmoji emoji);

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
  XenEmojifyProvider({
    super.key,
    required super.child,
    required this.dockController,
    required this.setCurrentEmoji,
    required this.selectedEmojiAnimation,
    this.currentEmoji,
  });

  ///
  static XenEmojifyProvider of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<XenEmojifyProvider>();
    if (provider == null) {
      throw FlutterError('XenEmojifyProvider not found in context');
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
