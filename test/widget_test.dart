import 'package:avora/core/theme/theme_controller.dart';
import 'package:avora/main.dart';
import 'package:flutter/material.dart';
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
  testWidgets('renders the AVORA foundation screen', (tester) async {
    final controller = ThemeController(store: _MemoryThemeStore());

    await tester.pumpWidget(AvoraApp(themeController: controller));

    expect(find.text('AVORA'), findsOneWidget);
    expect(find.text('A quieter space for music.'), findsOneWidget);
  });

  testWidgets('switches to the AMOLED palette when selected', (tester) async {
    final controller = ThemeController(store: _MemoryThemeStore());

    await tester.pumpWidget(AvoraApp(themeController: controller));
    await controller.setMode(AvoraThemeMode.amoled);
    await tester.pump();

    final app = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(app.themeMode, ThemeMode.dark);
    expect(app.darkTheme?.scaffoldBackgroundColor, const Color(0xFF000000));
  });
}
