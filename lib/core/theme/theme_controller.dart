import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AvoraThemeMode {
  system,
  light,
  dark,
  amoled;

  static AvoraThemeMode fromStorage(String? value) {
    for (final mode in values) {
      if (mode.name == value) return mode;
    }
    return AvoraThemeMode.system;
  }

  ThemeMode get materialThemeMode => switch (this) {
        AvoraThemeMode.system => ThemeMode.system,
        AvoraThemeMode.light => ThemeMode.light,
        AvoraThemeMode.dark || AvoraThemeMode.amoled => ThemeMode.dark,
      };
}

abstract interface class ThemePreferenceStore {
  Future<String?> readThemeMode();
  Future<void> writeThemeMode(String value);
}

class SharedPreferencesThemeStore implements ThemePreferenceStore {
  SharedPreferencesThemeStore({SharedPreferencesAsync? preferences})
      : _preferences = preferences ?? SharedPreferencesAsync();

  static const _key = 'appearance.theme_mode';

  final SharedPreferencesAsync _preferences;

  @override
  Future<String?> readThemeMode() => _preferences.getString(_key);

  @override
  Future<void> writeThemeMode(String value) =>
      _preferences.setString(_key, value);
}

/// Owns the selected appearance mode and persists it independently of widgets.
class ThemeController extends ChangeNotifier {
  ThemeController({required ThemePreferenceStore store}) : _store = store;

  final ThemePreferenceStore _store;

  AvoraThemeMode _mode = AvoraThemeMode.system;
  AvoraThemeMode get mode => _mode;

  Future<void> load() async {
    try {
      _mode = AvoraThemeMode.fromStorage(await _store.readThemeMode());
    } catch (_) {
      // Keep the safe system default if local preferences are unavailable.
      _mode = AvoraThemeMode.system;
    }
    notifyListeners();
  }

  Future<void> setMode(AvoraThemeMode mode) async {
    if (_mode == mode) return;

    _mode = mode;
    notifyListeners();
    await _store.writeThemeMode(mode.name);
  }
}
