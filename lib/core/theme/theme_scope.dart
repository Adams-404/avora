import 'package:flutter/material.dart';

import 'theme_controller.dart';

/// Exposes the [ThemeController] to every route, including modal sheets.
///
/// The theme controller lives above [MaterialApp] so sheets pushed onto the
/// navigator can read and update it without threading it through constructors.
class ThemeControllerScope extends InheritedNotifier<ThemeController> {
  const ThemeControllerScope({
    super.key,
    required ThemeController controller,
    required super.child,
  }) : super(notifier: controller);

  static ThemeController of(BuildContext context) {
    final ThemeControllerScope? scope =
        context.dependOnInheritedWidgetOfExactType<ThemeControllerScope>();
    assert(scope != null, 'No ThemeControllerScope found in the widget tree');
    return scope!.notifier!;
  }
}
