import 'package:flutter/material.dart';

import 'core/theme/avora_theme.dart';
import 'core/theme/theme_controller.dart';

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
          home: const _FoundationScreen(),
        );
      },
    );
  }
}

class _FoundationScreen extends StatelessWidget {
  const _FoundationScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'AVORA',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      letterSpacing: 5,
                    ),
              ),
              const SizedBox(height: 12),
              Text(
                'A quieter space for music.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
