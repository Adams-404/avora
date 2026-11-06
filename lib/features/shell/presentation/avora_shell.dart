import 'package:flutter/material.dart';

import '../theme/avora_spacing.dart';

enum AvoraDestination { home, search, library }

/// Responsive application shell shared by AVORA's primary destinations.
class AvoraShell extends StatefulWidget {
  const AvoraShell({super.key, this.miniPlayer});

  /// Supplied by the playback layer when a track is active.
  /// Keeping this optional prevents an empty player from occupying the UI.
  final Widget? miniPlayer;

  @override
  State<AvoraShell> createState() => _AvoraShellState();
}

class _AvoraShellState extends State<AvoraShell> {
  AvoraDestination _destination = AvoraDestination.home;

  int get _selectedIndex => AvoraDestination.values.indexOf(_destination);

  void _selectDestination(AvoraDestination destination) {
    setState(() => _destination = destination);
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width >= 720;
    final destinations = <NavigationDestination>[
      const NavigationDestination(
        icon: Icon(Icons.home_outlined),
        selectedIcon: Icon(Icons.home_rounded),
        label: 'Home',
      ),
      const NavigationDestination(
        icon: Icon(Icons.search_rounded),
        label: 'Search',
      ),
      const NavigationDestination(
        icon: Icon(Icons.library_music_outlined),
        selectedIcon: Icon(Icons.library_music_rounded),
        label: 'Library',
      ),
    ];

    final pages = const <Widget>[
      _HomeScreen(),
      _SearchScreen(),
      _LibraryScreen(),
    ];

    return PopScope(
      canPop: _destination == AvoraDestination.home,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && _destination != AvoraDestination.home) {
          _selectDestination(AvoraDestination.home);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Row(
            children: [
              if (isWide)
                NavigationRail(
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: (index) => _selectDestination(
                    AvoraDestination.values[index],
                  ),
                  labelType: NavigationRailLabelType.all,
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home_rounded),
                      label: Text('Home'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.search_rounded),
                      label: Text('Search'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.library_music_outlined),
                      selectedIcon: Icon(Icons.library_music_rounded),
                      label: Text('Library'),
                    ),
                  ],
                ),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: IndexedStack(
                        index: _selectedIndex,
                        children: pages,
                      ),
                    ),
                    if (widget.miniPlayer case final player?)
                      player,
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: isWide
            ? null
            : NavigationBar(
                selectedIndex: _selectedIndex,
                onDestinationSelected: (index) => _selectDestination(
                  AvoraDestination.values[index],
                ),
                destinations: destinations,
              ),
      ),
    );
  }
}

class _HomeScreen extends StatelessWidget {
  const _HomeScreen();

  @override
  Widget build(BuildContext context) {
    return const _DestinationPage(
      eyebrow: 'AVORA',
      title: 'Find your next favourite.',
      description:
          'A quieter space for music. Your discovery feed will live here.',
    );
  }
}

class _SearchScreen extends StatelessWidget {
  const _SearchScreen();

  @override
  Widget build(BuildContext context) {
    return const _DestinationPage(
      eyebrow: 'EXPLORE',
      title: 'Search',
      description:
          'Search across the music catalogue. Search becomes available when the catalogue connection is added.',
    );
  }
}

class _LibraryScreen extends StatelessWidget {
  const _LibraryScreen();

  @override
  Widget build(BuildContext context) {
    return const _DestinationPage(
      eyebrow: 'YOUR MUSIC',
      title: 'Library',
      description:
          'Your saved tracks and playlists will be collected here.',
    );
  }
}

class _DestinationPage extends StatelessWidget {
  const _DestinationPage({
    required this.eyebrow,
    required this.title,
    required this.description,
  });

  final String eyebrow;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return LayoutBuilder(
      builder: (context, constraints) {
        final horizontalPadding =
            constraints.maxWidth >= 720 ? 48.0 : AvoraSpacing.lg;
        return SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            horizontalPadding,
            AvoraSpacing.xl,
            horizontalPadding,
            AvoraSpacing.xxl,
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 920),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  eyebrow,
                  style: textTheme.labelMedium?.copyWith(
                    letterSpacing: 2.2,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: AvoraSpacing.md),
                Text(
                  title,
                  style: textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    letterSpacing: -1.1,
                  ),
                ),
                const SizedBox(height: AvoraSpacing.sm),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 480),
                  child: Text(
                    description,
                    style: textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
