import 'package:flutter/material.dart';

import '../../../core/theme/avora_spacing.dart';
import '../../../core/widgets/avora_page.dart';
import '../../../core/widgets/page_header.dart';
import '../../../core/widgets/section_header.dart';

/// Search, deliberately inert until there is something to search.
///
/// A live field that returned nothing would imply the catalogue is empty rather
/// than absent, so the input is disabled and the reason is stated.
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme scheme = theme.colorScheme;

    return AvoraPage(
      children: <Widget>[
        const PageHeader(
          eyebrow: 'EXPLORE',
          title: 'Search',
          description:
              'Search across the music catalogue. Search becomes available '
              'when the catalogue connection is added.',
        ),
        const SizedBox(height: AvoraSpacing.xl),
        TextField(
          enabled: false,
          decoration: InputDecoration(
            hintText: 'Tracks, artists and playlists',
            prefixIcon: const Icon(Icons.search_rounded),
            filled: true,
            fillColor: scheme.surface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AvoraRadii.md),
              borderSide: BorderSide(color: scheme.outline),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AvoraRadii.md),
              borderSide: BorderSide(color: scheme.outline),
            ),
          ),
        ),
        const SizedBox(height: AvoraSpacing.sm),
        Text(
          'Search stays off until a music provider is connected. There is '
          'nothing to query yet.',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: scheme.onSurfaceVariant,
            height: 1.5,
          ),
        ),
        const SizedBox(height: AvoraSpacing.xl),
        const SectionHeader(title: 'What search will cover'),
        const SizedBox(height: AvoraSpacing.sm),
        Text(
          'Tracks, artists and playlists from the connected catalogue, with '
          'results you can play or save. Recent searches will be stored on '
          'this device only.',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: scheme.onSurfaceVariant,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
