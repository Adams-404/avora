import 'package:flutter/material.dart';

import '../theme/avora_spacing.dart';

/// A quiet label above a group of content: hierarchy from type and space, not
/// from rules or cards.
class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title, this.caption});

  final String title;
  final String? caption;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final String? caption = this.caption;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        if (caption != null) ...<Widget>[
          const SizedBox(height: AvoraSpacing.xxs),
          Text(
            caption,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ],
    );
  }
}
