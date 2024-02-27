// BSD License. Copyright © Kiran Paudel. All rights reserved
import 'package:flutter/widgets.dart';
import 'package:xen_emojify/src/xen_emoji.dart';

///
class XenEmojifyState extends ChangeNotifier {
  bool _isDockVisible = false;
  XenEmoji? _currentEmoji;

  ///
  bool get isDockVisible => _isDockVisible;

  ///
  XenEmoji? get currentEmoji => _currentEmoji;

  ///
  void showDock() {
    _isDockVisible = true;
    notifyListeners();
  }

  ///
  void hideDock() {
    _isDockVisible = false;
    notifyListeners();
  }

  ///
  void toggleDock() {
    _isDockVisible = !_isDockVisible;
    notifyListeners();
  }

  ///
  void setCurrentEmoji(XenEmoji emoji) {
    _currentEmoji = emoji;
    notifyListeners();
  }
}

///
class XenEmojifyStateProvider extends InheritedWidget {
  ///
  final XenEmojifyState state;

  ///
  XenEmojifyStateProvider({
    Key? key,
    required this.state,
    required Widget child,
  }) : super(key: key, child: child);

  ///
  static XenEmojifyState of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<XenEmojifyStateProvider>();
    if (provider == null) {
      throw FlutterError('XenEmojifyStateProvider not found in context');
    }
    return provider.state;
  }

  @override
  bool updateShouldNotify(XenEmojifyStateProvider oldWidget) {
    return state != oldWidget.state;
  }
}
