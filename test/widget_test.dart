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

/// The shell switches to a navigation rail at 720 logical pixels, so the phone
/// layout needs an explicitly small test surface.
void _usePhoneSurface(WidgetTester tester) {
  tester.view.physicalSize = const Size(400, 800);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
}

void main() {
  testWidgets('opens on Home and is honest about the missing catalogue', (
    WidgetTester tester,
  ) async {
    _usePhoneSurface(tester);
    final controller = ThemeController(store: _MemoryThemeStore());

    await tester.pumpWidget(AvoraApp(themeController: controller));

    expect(find.text('Find your next favourite.'), findsOneWidget);
    expect(find.text('No music source connected'), findsOneWidget);
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
  });

  testWidgets('navigates between Home, Search and Library', (
    WidgetTester tester,
  ) async {
    _usePhoneSurface(tester);
    final controller = ThemeController(store: _MemoryThemeStore());

    await tester.pumpWidget(AvoraApp(themeController: controller));

    await tester.tap(find.text('Search').last);
    await tester.pumpAndSettle();
    const searchNote = 'Search stays off until a music provider is connected. '
        'There is nothing to query yet.';
    expect(find.text(searchNote), findsOneWidget);

    await tester.tap(find.text('Library').last);
    await tester.pumpAndSettle();
    expect(find.text('Your library is empty'), findsOneWidget);

    await tester.tap(find.text('Home').last);
    await tester.pumpAndSettle();
    expect(find.text('Find your next favourite.'), findsOneWidget);
  });

  testWidgets('changes appearance from the settings sheet', (
    WidgetTester tester,
  ) async {
    _usePhoneSurface(tester);
    final controller = ThemeController(store: _MemoryThemeStore());

    await tester.pumpWidget(AvoraApp(themeController: controller));

    await tester.tap(find.byTooltip('Settings').first);
    await tester.pumpAndSettle();
    expect(find.text('Appearance'), findsOneWidget);

    await tester.tap(find.text('AMOLED'));
    await tester.pumpAndSettle();

    final app = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(app.themeMode, ThemeMode.dark);
    expect(app.darkTheme?.scaffoldBackgroundColor, const Color(0xFF000000));
    expect(controller.mode, AvoraThemeMode.amoled);
  });

  testWidgets('remembers the appearance choice in the store', (
    WidgetTester tester,
  ) async {
    _usePhoneSurface(tester);
    final store = _MemoryThemeStore();
    final controller = ThemeController(store: store);

    await tester.pumpWidget(AvoraApp(themeController: controller));

    await tester.tap(find.byTooltip('Settings').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Light'));
    await tester.pumpAndSettle();

    expect(store.value, AvoraThemeMode.light.name);
  });
}
