import 'package:avora/core/theme/avora_colors.dart';
import 'package:avora/core/theme/theme_controller.dart';
import 'package:flutter_test/flutter_test.dart';

class _MemoryThemeStore implements ThemePreferenceStore {
  String? value;

  @override
  Future<String?> readThemeMode() async => value;

  @override
  Future<void> writeThemeMode(String value) async {
    this.value = value;
  }
}

void main() {
  group('ThemeController', () {
    test('defaults to system mode when no preference exists', () async {
      final controller = ThemeController(store: _MemoryThemeStore());

      await controller.load();

      expect(controller.mode, AvoraThemeMode.system);
    });

    test('restores a saved mode', () async {
      final store = _MemoryThemeStore()..value = 'amoled';
      final controller = ThemeController(store: store);

      await controller.load();

      expect(controller.mode, AvoraThemeMode.amoled);
    });

    test('falls back to system for an unknown stored value', () async {
      final store = _MemoryThemeStore()..value = 'cinema';
      final controller = ThemeController(store: store);

      await controller.load();

      expect(controller.mode, AvoraThemeMode.system);
    });

    test('persists a changed mode', () async {
      final store = _MemoryThemeStore();
      final controller = ThemeController(store: store);

      await controller.setMode(AvoraThemeMode.dark);

      expect(store.value, 'dark');
    });
  });

  test('AMOLED canvas is true black', () {
    expect(AvoraColors.amoledBackground, const Color(0xFF000000));
  });
}
