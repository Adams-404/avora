import 'package:flutter/material.dart';

import '../../features/settings/presentation/settings_sheet.dart';
import '../theme/avora_spacing.dart';

/// The top of every destination: eyebrow, title and a short description, with
/// the settings entry point aligned to the top right.
class PageHeader extends StatelessWidget {
  const PageHeader({
    super.key,
    required this.eyebrow,
    required this.title,
    required this.description,
  });

  final String eyebrow;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme scheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                eyebrow,
                style: theme.textTheme.labelMedium?.copyWith(
                  letterSpacing: 2.2,
                  fontWeight: FontWeight.w600,
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ),
            IconButton(
              onPressed: () => showAvoraSettingsSheet(context),
              icon: const Icon(Icons.settings_outlined),
              tooltip: 'Settings',
              visualDensity: VisualDensity.compact,
            ),
          ],
        ),
        const SizedBox(height: AvoraSpacing.md),
        Text(
          title,
          style: theme.textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: -1.1,
          ),
        ),
        const SizedBox(height: AvoraSpacing.sm),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Text(
            description,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: scheme.onSurfaceVariant,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
