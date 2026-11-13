import 'package:flutter/material.dart';

import '../../../core/theme/avora_spacing.dart';
import '../../../core/widgets/avora_page.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/page_header.dart';
import '../../../core/widgets/section_header.dart';

/// The discovery surface.
///
/// No provider is connected yet, so Home says so plainly rather than dressing
/// up sample content as a catalogue.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return AvoraPage(
      children: <Widget>[
        const PageHeader(
          eyebrow: 'AVORA',
          title: 'Find your next favourite.',
          description: 'A quieter space for music.',
        ),
        const SizedBox(height: AvoraSpacing.xl),
        const _CatalogueCard(),
        const SizedBox(height: AvoraSpacing.xl),
        const SectionHeader(
          title: 'Recently played',
          caption: 'Only what you actually play.',
        ),
        const SizedBox(height: AvoraSpacing.sm),
        const EmptyState(
          icon: Icons.history,
          title: 'Nothing played yet',
          message:
              'Tracks you play will appear here. Playback arrives with the '
              'music provider.',
        ),
        const SizedBox(height: AvoraSpacing.lg),
        Text(
          'AVORA leaves these sections out until there is real content to '
          'show — no sample tracks, no invented recommendations.',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

class _CatalogueCard extends StatelessWidget {
  const _CatalogueCard();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme scheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(AvoraSpacing.lg),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AvoraRadii.lg),
        border: Border.all(color: scheme.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                'CATALOGUE',
                style: theme.textTheme.labelMedium?.copyWith(
                  letterSpacing: 1.6,
                  fontWeight: FontWeight.w600,
                  color: scheme.onSurfaceVariant,
                ),
              ),
              const Spacer(),
              Text(
                'Not connected',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: AvoraSpacing.md),
          Text(
            'No music source connected',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AvoraSpacing.xs),
          Text(
            'AVORA streams from music providers. Audius is the first one '
            'planned; until it is connected there is no catalogue to browse, '
            'search or play.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: scheme.onSurfaceVariant,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
