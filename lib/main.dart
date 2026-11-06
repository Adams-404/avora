import 'package:flutter/material.dart';

import 'core/theme/avora_theme.dart';
import 'core/theme/theme_controller.dart';
import 'features/shell/presentation/avora_shell.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeController = ThemeController(
    store: SharedPreferencesThemeStore(),
  );
  await themeController.load();

  runApp(AvoraApp(themeController: themeController));
}

class AvoraApp extends StatelessWidget {
  const AvoraApp({required this.themeController, super.key});

  final ThemeController themeController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: themeController,
      builder: (context, _) {
        final isAmoled = themeController.mode == AvoraThemeMode.amoled;

        return MaterialApp(
          title: 'AVORA',
          debugShowCheckedModeBanner: false,
          theme: AvoraTheme.light,
          darkTheme: isAmoled ? AvoraTheme.amoled : AvoraTheme.dark,
          themeMode: themeController.mode.materialThemeMode,
          home: const AvoraShell(),
        );
      },
    );
  }
}
