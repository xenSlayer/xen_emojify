// BSD License. Copyright © Kiran Paudel. All rights reserved
import 'package:flutter/widgets.dart';
import 'package:xen_emojify/src/xen_emoji.dart';

///
class XenEmojifyProvider extends InheritedWidget {
  ///
  final OverlayPortalController dockController;

  ///
  final XenEmoji? currentEmoji;

  ///
  final Function(XenEmoji emoji) setCurrentEmoji;

  ///
  XenEmojifyProvider({
    required Widget child,
    required this.dockController,
    required this.setCurrentEmoji,
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
