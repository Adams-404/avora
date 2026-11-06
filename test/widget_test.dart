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
  testWidgets('renders the AVORA home destination', (tester) async {
    final controller = ThemeController(store: _MemoryThemeStore());

    await tester.pumpWidget(AvoraApp(themeController: controller));

    expect(find.text('Find your next favourite.'), findsOneWidget);
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
  });

  testWidgets('navigates between Home, Search and Library', (tester) async {
    final controller = ThemeController(store: _MemoryThemeStore());

    await tester.pumpWidget(AvoraApp(themeController: controller));

    await tester.tap(find.text('Search').last);
    await tester.pumpAndSettle();
    expect(find.text('Search across the music catalogue. Search becomes '
        'available when the catalogue connection is added.'), findsOneWidget);

    await tester.tap(find.text('Library').last);
    await tester.pumpAndSettle();
    expect(find.text('Your saved tracks and playlists will be collected '
        'here.'), findsOneWidget);

    await tester.tap(find.text('Home').last);
    await tester.pumpAndSettle();
    expect(find.text('Find your next favourite.'), findsOneWidget);
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
