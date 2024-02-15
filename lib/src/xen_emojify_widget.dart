// BSD License. Copyright © Kiran Paudel. All rights reserved
import 'package:flutter/material.dart';
import 'package:xen_emojify/xen_emojify.dart';

/// UNUSED
///
///
/// [EmojifyWidget] is a widget that allows you to display emojis

class EmojifyWidget extends StatelessWidget {
  ///
  EmojifyWidget({
    required this.xenEmojifyDock,
    this.onTap,
    this.padding = const EdgeInsets.all(8.0),
    this.defaultWidget = const Icon(Icons.add_circle_outline_rounded),
  });

  /// The dock to be displayed when tapped
  ///
  /// contains the list of emojis
  final XenEmojifyDock xenEmojifyDock;

  /// Perform certain action when tapped
  ///
  /// Like calling other methods
  final VoidCallback? onTap;

  /// The padding around the main selection widget and the placeholder
  ///
  /// default: [EdgeInsets.all(8.0)]
  final EdgeInsetsGeometry padding;

  /// The default widget to be displayed
  ///
  /// Example a button or a text
  ///
  /// default: [Icon(Icons.add_circle_outline_rounded)]
  final Widget defaultWidget;

  final _borderRadius = BorderRadius.circular(32);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey[200],
      borderRadius: _borderRadius,
      child: InkWell(
        borderRadius: _borderRadius,
        onTap: onTap,
        child: Padding(padding: padding, child: defaultWidget),
      ),
    );
  }
}