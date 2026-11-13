import 'package:flutter/material.dart';

import '../../../core/theme/avora_spacing.dart';
import '../../../core/widgets/avora_page.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/page_header.dart';

/// The personal collection. Empty because nothing can be saved yet.
class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return AvoraPage(
      children: <Widget>[
        const PageHeader(
          eyebrow: 'YOUR MUSIC',
          title: 'Library',
          description:
              'Your saved tracks and playlists will be collected here.',
        ),
        const SizedBox(height: AvoraSpacing.xl),
        const EmptyState(
          icon: Icons.library_music_outlined,
          title: 'Your library is empty',
          message:
              'Liked tracks, playlists and recently played music will collect '
              'here. Nothing here needs an account.',
        ),
        const SizedBox(height: AvoraSpacing.sm),
        Text(
          'There is nothing to save yet: liking and playlists need playback '
          'first.',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
