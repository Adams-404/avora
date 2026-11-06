import 'package:flutter/material.dart';

import 'avora_colors.dart';

/// AVORA's three deliberately neutral visual palettes.
abstract final class AvoraTheme {
  static ThemeData get light => _build(
        brightness: Brightness.light,
        background: AvoraColors.lightBackground,
        surface: AvoraColors.lightSurface,
        surfaceLow: AvoraColors.lightSurfaceLow,
        foreground: AvoraColors.lightForeground,
        muted: AvoraColors.lightMuted,
        outline: AvoraColors.lightOutline,
        accent: AvoraColors.lightAccent,
      );

  static ThemeData get dark => _build(
        brightness: Brightness.dark,
        background: AvoraColors.darkBackground,
        surface: AvoraColors.darkSurface,
        surfaceLow: AvoraColors.darkSurfaceLow,
        foreground: AvoraColors.darkForeground,
        muted: AvoraColors.darkMuted,
        outline: AvoraColors.darkOutline,
        accent: AvoraColors.darkAccent,
      );

  static ThemeData get amoled => _build(
        brightness: Brightness.dark,
        background: AvoraColors.amoledBackground,
        surface: AvoraColors.amoledSurface,
        surfaceLow: AvoraColors.amoledSurfaceLow,
        foreground: AvoraColors.amoledForeground,
        muted: AvoraColors.amoledMuted,
        outline: AvoraColors.amoledOutline,
        accent: AvoraColors.amoledAccent,
      );

  static ThemeData _build({
    required Brightness brightness,
    required Color background,
    required Color surface,
    required Color surfaceLow,
    required Color foreground,
    required Color muted,
    required Color outline,
    required Color accent,
  }) {
    final isLight = brightness == Brightness.light;
    final scheme = ColorScheme(
      brightness: brightness,
      primary: accent,
      onPrimary: isLight ? Colors.white : const Color(0xFF171715),
      secondary: muted,
      onSecondary: isLight ? Colors.white : const Color(0xFF171715),
      error: const Color(0xFFBA1A1A),
      onError: Colors.white,
      surface: surface,
      onSurface: foreground,
      surfaceContainerLowest: background,
      surfaceContainerLow: background,
      surfaceContainer: surface,
      surfaceContainerHigh: surfaceLow,
      surfaceContainerHighest: surfaceLow,
      outline: outline,
      outlineVariant: outline,
      shadow: Colors.black,
      scrim: Colors.black,
      inverseSurface: foreground,
      onInverseSurface: background,
      inversePrimary: muted,
    );

    final baseTextTheme = isLight
        ? Typography.material2021().black
        : Typography.material2021().white;
    final textTheme = baseTextTheme.apply(
      bodyColor: foreground,
      displayColor: foreground,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: background,
      canvasColor: background,
      dividerColor: outline,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        foregroundColor: foreground,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
      ),
      iconTheme: IconThemeData(color: foreground),
      listTileTheme: ListTileThemeData(
        iconColor: muted,
        textColor: foreground,
        minVerticalPadding: 8,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: surfaceLow,
        contentTextStyle: TextStyle(color: foreground),
        behavior: SnackBarBehavior.floating,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: accent,
        linearTrackColor: outline,
      ),
      splashFactory: InkSparkle.splashFactory,
    );
  }
}
