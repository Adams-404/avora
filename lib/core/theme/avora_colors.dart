import 'package:flutter/material.dart';

/// Semantic, deliberately restrained colours used throughout AVORA.
abstract final class AvoraColors {
  // Light surfaces.
  static const lightBackground = Color(0xFFF7F7F5);
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightSurfaceLow = Color(0xFFF1F1EE);
  static const lightForeground = Color(0xFF191917);
  static const lightMuted = Color(0xFF686862);
  static const lightOutline = Color(0xFFE3E3DE);
  static const lightAccent = Color(0xFF252522);

  // Dark surfaces.
  static const darkBackground = Color(0xFF111110);
  static const darkSurface = Color(0xFF1A1A18);
  static const darkSurfaceLow = Color(0xFF222220);
  static const darkForeground = Color(0xFFF1F1EC);
  static const darkMuted = Color(0xFFA7A79F);
  static const darkOutline = Color(0xFF343430);
  static const darkAccent = Color(0xFFE7E7DF);

  // AMOLED uses true black for the canvas and subtle separation for controls.
  static const amoledBackground = Color(0xFF000000);
  static const amoledSurface = Color(0xFF0D0D0D);
  static const amoledSurfaceLow = Color(0xFF151515);
  static const amoledForeground = Color(0xFFF4F4F0);
  static const amoledMuted = Color(0xFFA8A8A2);
  static const amoledOutline = Color(0xFF292929);
  static const amoledAccent = Color(0xFFEAEAE4);
}
