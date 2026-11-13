import 'package:flutter/material.dart';

import '../../../core/theme/avora_spacing.dart';
import '../../../core/theme/theme_controller.dart';
import '../../../core/theme/theme_scope.dart';

extension on AvoraThemeMode {
  String get label => switch (this) {
        AvoraThemeMode.system => 'System',
        AvoraThemeMode.light => 'Light',
        AvoraThemeMode.dark => 'Dark',
        AvoraThemeMode.amoled => 'AMOLED',
      };

  String get description => switch (this) {
        AvoraThemeMode.system => 'Follow the device setting',
        AvoraThemeMode.light => 'Neutral off-white surfaces',
        AvoraThemeMode.dark => 'Layered near-black surfaces',
        AvoraThemeMode.amoled => 'True black for OLED screens',
      };
}

Future<void> showAvoraSettingsSheet(BuildContext context) {
  final ColorScheme scheme = Theme.of(context).colorScheme;

  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    showDragHandle: true,
    backgroundColor: scheme.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(AvoraRadii.lg)),
    ),
    builder: (BuildContext context) => const AvoraSettingsSheet(),
  );
}

/// Settings containing only controls that actually do something.
class AvoraSettingsSheet extends StatelessWidget {
  const AvoraSettingsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme scheme = theme.colorScheme;
    final ThemeController controller = ThemeControllerScope.of(context);
    final AvoraThemeMode selected = controller.mode;

    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          AvoraSpacing.lg,
          0,
          AvoraSpacing.lg,
          AvoraSpacing.lg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Appearance',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AvoraSpacing.xs),
            Text(
              'Applies immediately and is remembered on this device.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: scheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AvoraSpacing.sm),
            for (final AvoraThemeMode mode in AvoraThemeMode.values)
              ListTile(
                contentPadding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
                title: Text(
                  mode.label,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight:
                        selected == mode ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
                subtitle: Text(
                  mode.description,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                trailing: selected == mode
                    ? Icon(Icons.check, size: 18, color: scheme.primary)
                    : const SizedBox(width: 18),
                onTap: () async {
                  await controller.setMode(mode);
                },
              ),
            const SizedBox(height: AvoraSpacing.sm),
            Divider(color: scheme.outline, height: 1),
            const SizedBox(height: AvoraSpacing.md),
            Text(
              'No catalogue provider is connected yet. Home, Search and '
              'Library describe what is coming instead of showing sample data.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: scheme.onSurfaceVariant,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
